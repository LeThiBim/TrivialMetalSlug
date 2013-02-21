//
//  Hero.h
//  AnimBear
//
//  Created by gnt on 2/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Hero : CCSpriteBatchNode {
    
    CCSprite* _hero;
    CCAction* _standAction;
    CCAction* _walkAction;
    CCAction* _moveAction;
    BOOL _moving;
        
}

@property (nonatomic, assign) CCSprite* hero;
@property (nonatomic, assign) CCAction* standAction;
@property (nonatomic, assign) CCAction* walkAction;

@property (nonatomic, assign) CCAction* moveAction;

@property (nonatomic, assign) BOOL moving;

- (void) walk:(CGPoint) touchLocation;
@end
