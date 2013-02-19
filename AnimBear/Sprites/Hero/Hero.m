//
//  Hero.m
//  AnimBear
//
//  Created by gnt on 2/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"


@implementation Hero
@synthesize hero = _hero;
@synthesize standAction = _standAction;
@synthesize moving = _moving;
@synthesize walkAction = _walkAction;
@synthesize moveAction = _moveAction;
@synthesize isMoving = _isMoving;
- (id) init
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"MachineGun.plist"];
  
    if( (self=[super initWithFile:@"MachineGun.png" capacity:29]) ) {
            
        NSMutableArray *standAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 16; ++i) {
            [standAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"Stand_%02d.gif", i]]];
        }
        
        //------------------------------------------------------------------------
        CCAnimation *standAnim = [CCAnimation
                                 animationWithSpriteFrames:standAnimFrames delay:0.1f];
        
        
        //------------------------------------------------------------------------
        CGSize winSize = [CCDirector sharedDirector].winSize;
        _hero = [CCSprite spriteWithSpriteFrameName:@"Stand_01.gif"];
        _hero.position = ccp(winSize.width/2, winSize.height/2);
        _standAction = [[CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:standAnim]] retain];
        _standAction.tag = 100;
        [_hero runAction:_standAction];
        [self addChild:_hero];
        
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for (int i = 1; i <=16; ++i)
        {
            [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]
                                       spriteFrameByName:[NSString stringWithFormat:@"Walk_%02d.gif", i]]];
        }
        
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        _walkAction = [[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]] retain];
        _walkAction.tag = 101;
        
        
    } 
    
    return self;

}
- (void) dealloc
{
    SAFE_RELEASE_OBJECT(_hero);
    SAFE_RELEASE_OBJECT(_standAction);
    SAFE_RELEASE_OBJECT(_walkAction);
    SAFE_RELEASE_OBJECT(_moveAction);
    [super dealloc];
}
- (void) walk:(CGPoint) touchLocation
{
    float bearVelocity = 480.0/3.0;
    
    CGPoint moveDifference = ccpSub(touchLocation, _hero.position);
    
    
    float distanceToMove = ccpLength(moveDifference);
    
    
    float moveDuration = distanceToMove / bearVelocity;
    
    
    if (moveDifference.x < 0)
    {
        _hero.flipX = NO;
    } else
    {
        _hero.flipX = YES;
    }
    
    if ([_hero getActionByTag:102])
    {
        [_hero stopActionByTag:102];
    }

    
    // Check if hero is standing => stop standing
    if ([_hero getActionByTag:100])
    {
        [_hero stopActionByTag:100];
    }
    
    if (!_moving)
    {
        if (![_hero getActionByTag:101])
        {
            [_hero runAction:_walkAction];
        }

    }
    
    _moveAction = [CCSequence actions:
                       [CCMoveTo actionWithDuration:moveDuration position:touchLocation],
                       [CCCallFunc actionWithTarget:self selector:@selector(bearMoveEnded)],
                       nil];
    _moveAction.tag = 102;
    [_hero runAction:_moveAction];
    _moving = TRUE;
}

-(void)bearMoveEnded {
    
    if ([_hero getActionByTag:101])
    {
        [_hero stopAction:_walkAction];
    }
    
    if (![_hero getActionByTag:100])
    {
        [_hero runAction:_standAction];
    }
    _moving = FALSE;
}
- (void) update:(ccTime) dt
{
       
}
@end
