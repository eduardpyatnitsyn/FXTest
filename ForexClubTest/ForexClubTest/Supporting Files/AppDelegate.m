//
//  AppDelegate.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "AppDelegate.h"
#import "ECSlidingViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) ECSlidingViewController *slidingViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupControllersStack];
    
    return YES;
}

-(void) setupControllersStack{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    ViewController *topViewController        = [[NSBundle mainBundle] loadNibNamed:@"ViewController" owner:nil options:nil][0];
    UIViewController *underLeftViewController  = [[UIViewController alloc] init];
    
    // configure top view controller
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    underLeftViewController.view.backgroundColor = [UIColor whiteColor];
    
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    self.slidingViewController.underLeftViewController  = underLeftViewController;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.window.rootViewController = self.slidingViewController;
    
    [self.window makeKeyAndVisible];
}

- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
