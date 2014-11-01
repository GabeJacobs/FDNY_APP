//
//  TwitterTableView.h
//  FDNY
//
//  Created by Gabe Jacobs on 10/29/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTwitter.h"
#import "STTwitter.h"

@interface TwitterTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *statuses;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NSMutableArray *ids;

@property (nonatomic, strong) STTwitterAPI *twitter;

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verfier;

@end
