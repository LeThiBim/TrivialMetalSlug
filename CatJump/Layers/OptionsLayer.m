//
//  OptionsLayer.m
//  CatJump
//
//  Created by gnt on 1/29/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "OptionsLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"

@implementation OptionsLayer

-(void)backButtonPressed:(id)sender {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}

-(void)optionsButtonPressed:(id)sender {
    
    CCControlButton *button = (CCControlButton*) sender;
    NSString *difficultyLevel = @"Hard";
    if (button.tag == DIFFICULTY_EASY_BUTTON_TAG)
    {
        difficultyLevel = @"Easy";
    } else if(button.tag == DIFFICULTY_MEDIUM_BUTTON_TAG)
    {
        difficultyLevel = @"Medium";
    }
    NSLog(@"Difficulty is set to %@", difficultyLevel);
}
@end
