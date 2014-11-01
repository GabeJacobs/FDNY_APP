//
//  TabViewController.h
//  FDNY
//
//  Created by Gabe Jacobs on 10/27/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface TabViewController : UITabBarController <UITabBarDelegate>

@property (nonatomic, strong) FirstViewController *vc1;
@property (nonatomic, strong) SecondViewController *vc2;

@end
