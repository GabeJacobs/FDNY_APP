//
//  TabViewController.m
//  FDNY
//
//  Created by Gabe Jacobs on 10/27/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	self.tabBar.translucent = NO;

	self.tabBar.barStyle = UIBarStyleBlack;
	self.tabBar.tintColor = [UIColor whiteColor];
	//self.view.backgroundColor = [UIColor whiteColor];
	self.vc1 = [[FirstViewController alloc] init];
	self.vc2 = [[SecondViewController alloc] init];

	//[[UITabBar appearance] setTintColor:[UIColor blackColor]];

	
	self.viewControllers = [NSArray arrayWithObjects:self.vc1, self.vc2, nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
	
}
@end
