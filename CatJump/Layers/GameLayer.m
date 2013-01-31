//
//  GameLayer.m
//  CatJump
//
//  Created by Ray Wenderlich on 12/21/12.
//  Copyright 2012 Ray Wenderlich. All rights reserved.
//

//ha ha ha, Le Thi Bim

#import "GameLayer.h"
#import "CCBReader.h"
#import "SimpleAudioEngine.h"

#define kVehicleTypeNone -1
#define kVehicleTypeRedCar 0
#define kVehicleTypeYellowCar 1
#define kVehicleTypeDog 2
#define kVehicleTypeKid 3

@interface GameLayer() {
    CCLabelBMFont *livesLabel;
    CCLabelBMFont *dodgesLabel;
    CCSprite *cat;
    
    CCNode *_vehicles;
    BOOL _invincible;
    BOOL _jumping;
    double _nextSpawn;
    int _lives;
    int _dodges;
    CCSpriteBatchNode *_catJumpBatchNode;
    CCAnimation *_catJumpAnimation;
}
@end

@implementation GameLayer

- (id) init {
    self = [super init];
    if (self) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CatJumpAtlas.plist"];
        
        _catJumpBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"CatJumpAtlas.png"];
        [self addChild:_catJumpBatchNode z:1];
        
        _catJumpAnimation = [CCAnimation animation];
        [_catJumpAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cat_leap_1.png"]];
        [_catJumpAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cat_leap_2.png"]];
        [_catJumpAnimation setDelayPerUnit:0.625f];
        [_catJumpAnimation retain];
        
        // If you want to add this to the AnimationCache instead of retaining
        //[[CCAnimationCache sharedAnimationCache] addAnimation:catJumpAnimation name:@"catJumpAnim"];
        
        // Dog Animation
        CCAnimation *dogAnimation = [CCAnimation animation];
        [dogAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog_1.png"]];
        [dogAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog_2.png"]];
        [dogAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog_3.png"]];
        [dogAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog_4.png"]];
        [[CCAnimationCache sharedAnimationCache] addAnimation:dogAnimation name:@"dogAnimation"];
        
        // Kid Animation
        CCAnimation *kidAnimation = [CCAnimation animation];
        [kidAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kidontrike_1.png"]];
        [kidAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kidontrike_2.png"]];
        [kidAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kidontrike_3.png"]];
        [kidAnimation addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kidontrike_4.png"]];
        [[CCAnimationCache sharedAnimationCache] addAnimation:kidAnimation name:@"kidAnimation"];
        
        
        self.isTouchEnabled = YES;
        
        [self scheduleUpdate];
        
        _vehicles = [CCNode node];
        [self addChild:_vehicles];
        
        _lives = 9;
        _dodges = 0;
        
        double curTime = [[NSDate date] timeIntervalSince1970];
        _nextSpawn = curTime + 4;
        
    }
    return self;
}

- (void) didLoadFromCCB {
    [self setLives:_lives];
    [self setDodges:_dodges];
}

- (void) setDodges:(int) noOfDodges {
    dodgesLabel.string = [NSString stringWithFormat:@"Dodges:%d", noOfDodges];
}

- (void) setLives:(int) noOfLives {
    livesLabel.string = [NSString stringWithFormat:@"Lives:%d", noOfLives];
}

- (void)carDone:(id)sender {
    
    CCSprite *vehicle = (CCSprite *)sender;
    [vehicle removeFromParentAndCleanup:YES];
    
    _dodges++;
    [self setDodges:_dodges];
}

- (void)doneInvincible {
    _invincible = FALSE;
}

- (void)update:(ccTime)dt {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *vehicleSprite;
    // Spawn Vehicles (new)
    double curTime = [[NSDate date] timeIntervalSince1970];
    if (curTime > _nextSpawn) {
        
        int randomVehicle = arc4random() % 4;
        
        if (randomVehicle == kVehicleTypeRedCar) {
            // Red Car
            vehicleSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car1_1.png"]];
            [vehicleSprite setUserData:[NSNumber numberWithInt:kVehicleTypeRedCar]];
            CCSprite *wheel1 = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car1_tire.png"]];
            CCSprite *wheel2 = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car1_tire.png"]];
            id tireRotateAction1 = [CCRotateBy actionWithDuration:1.0f angle:360.0f]; // Ray, these are backwards on purpose as a lab exercise.
            id tireRotateAction2 = [CCRotateBy actionWithDuration:1.0f angle:360.0f];
            [wheel1 runAction:[CCRepeatForever actionWithAction:tireRotateAction1]];
            [wheel2 runAction:[CCRepeatForever actionWithAction:tireRotateAction2]];
            [vehicleSprite addChild:wheel1];
            [vehicleSprite addChild:wheel2];
            [wheel1 setPosition:ccp(65,18)];
            [wheel2 setPosition:ccp(212,18)];
            
        } else if (randomVehicle == kVehicleTypeYellowCar) {
            // Yellow Car (Same code as Red Car except for wheel placement, re-listed for clarity. Consilidate in your own games)
            vehicleSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car2_1.png"]];
            [vehicleSprite setUserData:[NSNumber numberWithInt:kVehicleTypeYellowCar]];
            CCSprite *wheel1 = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car2_tire.png"]];
            CCSprite *wheel2 = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"car2_tire.png"]];
            id tireRotateAction1 = [CCRotateBy actionWithDuration:1.0f angle:-360.0f];
            id tireRotateAction2 = [CCRotateBy actionWithDuration:1.0f angle:-360.0f];
            [wheel1 runAction:[CCRepeatForever actionWithAction:tireRotateAction1]];
            [wheel2 runAction:[CCRepeatForever actionWithAction:tireRotateAction2]];
            [vehicleSprite addChild:wheel1];
            [vehicleSprite addChild:wheel2];
            [wheel1 setPosition:ccp(62,15)];
            [wheel2 setPosition:ccp(195,15)];
            
        } else if (randomVehicle == kVehicleTypeDog) {
            // Dog
            vehicleSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog_1.png"]];
            [vehicleSprite setUserData:[NSNumber numberWithInt:kVehicleTypeDog]];
            
            // In your code, check that the animationByName did not return nil (due to memory warnings)
            CCAnimation *vehicleAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"dogAnimation"];
            
            vehicleAnimation.restoreOriginalFrame = NO;
            vehicleAnimation.delayPerUnit = 0.5f/ vehicleAnimation.frames.count;
            id animationAction = [CCAnimate actionWithAnimation:vehicleAnimation];
            
            [vehicleSprite runAction:[CCRepeatForever actionWithAction:animationAction]];
            
        } else {
            // Kid on Bike (Same code as Dog, re-listed for clarity. Consilidate in your own games)
            vehicleSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kidontrike_1.png"]];
            [vehicleSprite setUserData:[NSNumber numberWithInt:kVehicleTypeKid]];
            
            // In your code, check that the animationByName did not return nil (due to memory warnings)
            CCAnimation *vehicleAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"kidAnimation"];
            
            vehicleAnimation.restoreOriginalFrame = NO;
            vehicleAnimation.delayPerUnit = 0.5f/ vehicleAnimation.frames.count;
            id animationAction = [CCAnimate actionWithAnimation:vehicleAnimation];
            
            [vehicleSprite runAction:[CCRepeatForever actionWithAction:animationAction]];
            
        }
        
        // Common placement and movement code for all vehicles
        
        vehicleSprite.position = ccp(winSize.width + vehicleSprite.contentSize.width/2, 75);
        [_catJumpBatchNode addChild:vehicleSprite];
        
        [vehicleSprite runAction:[CCSequence actions:
                                  [CCMoveBy actionWithDuration:1.25 position:ccp(-winSize.width-vehicleSprite.contentSize.width, 0)],
                                  [CCCallFuncN actionWithTarget:self selector:@selector(carDone:)],
                                  nil]];
        
        float randomInterval = arc4random() % 3 + 1.5;
        _nextSpawn = curTime + randomInterval;
        
        
    }
    
    
    // Check for collisions
    if (!_invincible) {
        float insetAmtX = 10;
        float insetAmtY = 10;
        BOOL isCatColliding;
        CGRect catRect = CGRectInset(cat.boundingBox, insetAmtX, insetAmtY);
        CGRect vehicleRect;
        for (CCSprite *vehicle in _catJumpBatchNode.children) {
            if ([vehicle tag] == 1) {
                continue;  // No need to check if the Cat collides with itself
            }
            isCatColliding = NO;
            NSNumber *vehicleTypeNumber = (NSNumber*)[vehicle userData];
            int vehicleType = [vehicleTypeNumber intValue];
            
            if (vehicleType == kVehicleTypeRedCar) {
                CGPoint boundingBoxOrigin = vehicle.boundingBox.origin;
                CGRect carHood = CGRectMake(boundingBoxOrigin.x+10,boundingBoxOrigin.y , 40,80);
                insetAmtX = 50;
                insetAmtY = 10;
                vehicleRect = CGRectInset(vehicle.boundingBox,insetAmtX,insetAmtY);
                
                if ((CGRectIntersectsRect(catRect,carHood)) ||
                    (CGRectIntersectsRect(catRect, vehicleRect))) {
                    isCatColliding = YES;
                    CCLOG(@"Collided with Red Car");
                }
                
            } else if (vehicleType == kVehicleTypeYellowCar) {
                CGPoint boundingBoxOrigin = vehicle.boundingBox.origin;
                CGRect carHood = CGRectMake(boundingBoxOrigin.x+10,boundingBoxOrigin.y , 68,65);
                insetAmtX = 68;
                insetAmtY = 10;
                vehicleRect = CGRectInset(vehicle.boundingBox,insetAmtX,insetAmtY);
                
                if ((CGRectIntersectsRect(catRect,carHood)) ||
                    (CGRectIntersectsRect(catRect, vehicleRect))) {
                    isCatColliding = YES;
                    CCLOG(@"Collided with Yellow Car");
                }
                
                
            } else {
                // Dog or Kid
                CGRect vehicleRect = CGRectInset(vehicle.boundingBox, insetAmtX, insetAmtY);
                if (CGRectIntersectsRect(catRect, vehicleRect)) {
                    isCatColliding = YES;
                }
            }
            
            
            if (isCatColliding == YES) {
                // Play sound, take a hit, invincible, break out of the loop
                [[SimpleAudioEngine sharedEngine] playEffect:@"squish.wav"];
                _invincible = TRUE;
                [cat runAction:[CCSequence actions:
                                [CCBlink actionWithDuration:1.0 blinks:6],
                                [CCCallFunc actionWithTarget:self selector:@selector(doneInvincible)],
                                nil]];
                _lives--;
                [self setLives:_lives];
                
                if (_lives <= 0) {
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameOverScene.ccbi"]]];
                }
                break;
            }
        }
        
    }
}

- (void)doneJump {
    _jumping = FALSE;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!_jumping) {
        
        _jumping = TRUE;
        [[SimpleAudioEngine sharedEngine] playEffect:@"meow.wav"];
        
        CCLOG(@"Making the Cat Jump");
        _catJumpAnimation.restoreOriginalFrame = YES;
        CCAnimate *jumpAnimation = [CCAnimate actionWithAnimation:_catJumpAnimation];
        
        CCJumpBy *jumpAction = [CCJumpBy actionWithDuration:1.25 position:ccp(0,0) height:200 jumps:1];
        CCCallFunc *doneJumpAction = [CCCallFunc actionWithTarget:self selector:@selector(doneJump)];
        CCSequence *sequenceAction = [CCSequence actions:jumpAction,doneJumpAction, nil];
        
        
		[cat runAction:[CCSpawn actions:jumpAnimation,sequenceAction, nil]];
    }
    
}
@end
