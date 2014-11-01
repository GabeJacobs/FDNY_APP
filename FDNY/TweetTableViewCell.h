//
//  TweetTableViewCell.h
//  FDNY
//
//  Created by Gabe Jacobs on 10/30/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell



@property (nonatomic,strong) UIView* background;
@property (nonatomic,strong) UILabel* tweetLabel;
@property (nonatomic,strong) UILabel* handleLabel;
@property (nonatomic,strong) UIImageView* avatar;
@property (nonatomic,strong) NSString* tweetID;
@property (nonatomic,strong) NSString* date;

+ (TweetTableViewCell*)cellForTweet:(NSString*)tweet andDate:(NSString*)date reuseID:(NSString*)reuseID;
- (void)addDataToCell:(NSString*)tweet withDate:(NSString*)date andID:(NSString*)tweetID;
-(void)clickedCell;


@end
