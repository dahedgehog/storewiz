//
//  SWDAppDelegate.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDAppDelegate.h"

@implementation SWDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupCoreDataStack];
    [self customizeAppearance];
    
    return YES;
}

- (void)customizeAppearance
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-bg-glare.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"navbar-shadow.png"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                UITextAttributeTextColor:[UIColor whiteColor],
                          UITextAttributeTextShadowColor:[UIColor colorWithWhite:0.0 alpha:0.8],
                         UITextAttributeTextShadowOffset:[NSValue valueWithCGSize:CGSizeMake(0, 1)],
                                     UITextAttributeFont:[UIFont fontWithName:@"Interstate-Regular" size:20.0f]}];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4.0f forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:63.0f/255.0f green:167.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
}
				
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    [MagicalRecord cleanUp];
}

@end
