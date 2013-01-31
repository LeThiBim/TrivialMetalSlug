//
//  GameOverLayer.m
//  CatJump
//
//  Created by gnt on 1/31/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"

#define MAIN_MENU_BUTTON_TAG 1
#define PLAY_AGAIN_BUTTON_TAG 2

@implementation GameOverLayer

- (void) mainMenuButtonPressed:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

- (void)replayButtonPressed:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeUp transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameScene.ccbi"]]];
}

@end
