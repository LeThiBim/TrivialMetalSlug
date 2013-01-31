//
//  MainMenuLayer.m
//  MyCatJump
//
//  Created by gnt on 1/29/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"

@implementation MainMenuLayer

-(void)buttonPressed:(id)sender {
    CCControlButton *button = (CCControlButton*) sender;
    switch (button.tag) {
        case PLAY_BUTTON_TAG:
            
            //NSLog(@"HEO 1");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"GameScene.ccbi"]]];
            break;
        case OPTIONS_BUTTON_TAG:
            
            NSLog(@"HEO 2");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"OptionsScene.ccbi"]]];
            break;
        case ABOUT_BUTTON_TAG:
            
            NSLog(@"HEO 3");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"]]];
            break;
    }
}
@end
