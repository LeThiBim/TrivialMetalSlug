//
//  AboutLayer.m
//  CatJump
//
//  Created by gnt on 1/30/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "AboutLayer.h"
#import "CCControlButton.h"
#import "CCBReader.h"


@implementation AboutLayer

-(void)backButtonPressed:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:1.0 scene:[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"]]];
}
@end
