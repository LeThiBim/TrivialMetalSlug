//
//  HelloWorldLayer.h
//  AnimBear
//
//  Created by gnt on 1/31/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

#import <UIKit/UIKit.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Hero.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate, UIAccelerometerDelegate>
{
    // Add inside the HelloWorld interface
    Hero* _heroPlayer;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


@end
