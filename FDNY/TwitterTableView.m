//
//  TwitterTableView.m
//  FDNY
//
//  Created by Gabe Jacobs on 10/29/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "TwitterTableView.h"
#import "TweetTableViewCell.h"

@implementation TwitterTableView

- (id)initWithFrame:(CGRect)frame{
	
	self = [super initWithFrame:frame];
	if (self) {
		self.delegate = self;
		self.dataSource = self;
		self.statuses = [NSMutableArray array];
		self.dates = [NSMutableArray array];
		self.ids = [NSMutableArray array];

		
		self.twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"lI4EhKmv4jteYq2VmqJDVLR5S" consumerSecret:@"hzYPsP45kovMfuBbYeDtJXrBOfpAoTlu656ZZrlZSrLufNdeQ9"];
		
		[self.twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
			
			[self.twitter getUserTimelineWithScreenName:@"theBravest"
									  successBlock:^(NSArray *statuses) {
										  for(int i = 0; i < [statuses count]; i++){
											  self.statuses[i] = statuses[i][@"text"];
											  self.dates[i] = statuses[i][@"created_at"];
											  self.ids[i] = statuses[i][@"id"];
										  }
										  [self reloadData];
									  } errorBlock:^(NSError *error) {
									  }];
			
		} errorBlock:^(NSError *error) {
			NSLog(@"-- error %@", error);
		}];
		
		

	}
	
	return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}

- (TweetTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	NSString *cellText = @"";
	if([self.statuses count] > 0){
		NSLog(@"index is %ld", (long)indexPath.row);
		[cell addDataToCell:self.statuses[indexPath.row] withDate:self.dates[indexPath.row] andID:self.ids[indexPath.row]];
		//cellText = self.statuses[indexPath.row];
	}
	
	[cell.textLabel setText:cellText];
	[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0]];
	cell.separatorInset = UIEdgeInsetsZero;
	[cell.textLabel setTextColor:[UIColor colorWithRed:80.0f/255.0f green:136.0f/255.0f blue:187.0f/255.0f alpha:1.0]];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	// set the accessory view:
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	TweetTableViewCell *cell = (TweetTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
	[cell clickedCell];

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 100.0f;
}




@end
