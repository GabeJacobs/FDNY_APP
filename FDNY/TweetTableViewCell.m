//
//  TweetTableViewCell.m
//  FDNY
//
//  Created by Gabe Jacobs on 10/30/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	self.background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 90)];
	self.background.layer.cornerRadius = 6.0;
	self.background.backgroundColor =[UIColor colorWithWhite:.1 alpha:.4];
	[self addSubview:self.background];
	
	self.tweetLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 30, 215, 50)];
	self.tweetLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
	self.tweetLabel.textColor = [UIColor whiteColor];
	self.tweetLabel.numberOfLines = -1;
	[self addSubview:self.tweetLabel];
	self.tweetLabel.textAlignment = NSTextAlignmentNatural;

	
	self.handleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 100, 20)];
	self.handleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
	self.handleLabel.textColor = [UIColor whiteColor];
	self.handleLabel.text = @"theBravest";
	self.handleLabel.numberOfLines = -1;
	[self addSubview:self.handleLabel];
	
	self.avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
	self.avatar.frame = CGRectMake(7, 7, 30, 30);
	[self addSubview:self.avatar];
	
	
	self.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.layer.cornerRadius = 5.0;
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

+ (TweetTableViewCell*)cellForTweet:(NSString*)tweet andDate:(NSString*)date reuseID:(NSString*)reuseID {
	TweetTableViewCell* cell = nil;
	// Check what type of data the dictionary contains and create the correct cell.
		cell = [[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
		return cell;
}

- (void)addDataToCell:(NSString*)tweet withDate:(NSString*)date andID:(NSString*)tweetID {
	self.tweetLabel.text = tweet;
	[self.tweetLabel sizeToFit];
	if(self.tweetLabel.frame.size.height > 50){
		self.tweetLabel.frame = CGRectMake(45, 30, 215, 50);
	}
	self.tweetID = tweetID;



}


- (void)awakeFromNib {
    // Initialization code
}

-(void)clickedCell{
	
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/theBravest/status/%@",self.tweetID]]];
}


@end
