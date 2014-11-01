//
//  FirstViewController.m
//  FDNY
//
//  Created by Gabe Jacobs on 10/27/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "FirstViewController.h"
#import "STTwitterAPI.h"

#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
#define IS_IPHONE6 (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
#define IS_IPHONE6PLUS (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)
#define TABLEVIEWHEIGHT (IS_IPHONE4)?195:296


@interface FirstViewController ()

@end

@implementation FirstViewController

-(id)init{
	
	self.tabBarItem.title = @"Radio";
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.playing = NO;
	self.view.backgroundColor = [UIColor grayColor];
	
	UIImage *bgImage = [UIImage imageNamed:@"bg"];
	self.bg = [[UIImageView alloc] initWithFrame:self.view.frame];
	[self.bg setImage:bgImage];
	[self.view addSubview:self.bg];
	
	self.radioChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.radioChangeButton.frame = CGRectMake(0, 0, 200, 30);
	self.radioChangeButton.layer.cornerRadius = 5.0f;
	self.radioChangeButton.center = CGPointMake(self.view.center.x, 43);
	if(IS_IPHONE6PLUS){
		self.radioChangeButton.center = CGPointMake(self.view.center.x, 55);
	}
	self.radioChangeButton.backgroundColor = [UIColor whiteColor];
	[self.radioChangeButton addTarget:self action:@selector(dropDownList) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.radioChangeButton];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 0)];
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.tableView.center = CGPointMake(self.view.center.x, self.radioChangeButton.center.y + (self.tableView.frame.size.height/2) + 26);
	self.tableView.layer.cornerRadius = 5.0f;
	if(!IS_IPHONE4){
		self.tableView.scrollEnabled = NO;
	}
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self.view addSubview:self.tableView];
	
	self.twitterTableView = [[TwitterTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 290)];
	self.twitterTableView.backgroundColor = [UIColor clearColor];
	
	self.twitterTableView.center = CGPointMake(self.view.center.x, self.view.center.y - 70);
	if(IS_IPHONE4){
		self.twitterTableView.frame = CGRectMake(0, 0, self.view.frame.size.width - 20, 200);
		self.twitterTableView.center = CGPointMake(self.view.center.x, self.view.center.y - 70);

	}
	if(IS_IPHONE6 || IS_IPHONE6PLUS){
		self.twitterTableView.frame = CGRectMake(0, 0, self.view.frame.size.width - 20, 390);
		self.twitterTableView.center = CGPointMake(self.view.center.x, self.view.center.y - 70);
	}
	[self.view addSubview:self.twitterTableView];
	[self.twitterTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

	
	self.selectedRadioLabel = [[ UILabel alloc] initWithFrame:self.radioChangeButton.frame];
	self.selectedRadioLabel.center = CGPointMake(self.radioChangeButton.center.x + 9, self.radioChangeButton.center.y);
	self.selectedRadioLabel.text = @"Scanner Radio";
	[self.selectedRadioLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
	[self.selectedRadioLabel setTextColor:[UIColor colorWithRed:80.0f/255.0f green:136.0f/255.0f blue:187.0f/255.0f alpha:1.0]];
	[self.view addSubview:self.selectedRadioLabel];
	
	self.carrot = [[UIImageView alloc] initWithFrame:CGRectMake(self.selectedRadioLabel.frame.origin.x + 162, self.selectedRadioLabel.frame.origin.y + 7, 18, 18)];
	self.carrot.tintColor = [UIColor colorWithRed:80.0f/255.0f green:136.0f/255.0f blue:187.0f/255.0f alpha:1.0];
	[self.carrot setImage:[UIImage imageNamed:@"Carrot-Down"]];
	[self.view addSubview:self.carrot];
	
	
	self.radioStreams = [NSArray arrayWithObjects:@"http://www.thebravest.isprime.com:8060/tebizilisSC.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisE.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisM.mp3", @"http://thebravest.isprime.com:8060/tebizilisK.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisX.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisQ.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisS.mp3", @"http://www.thebravest.isprime.com:8060/tebizilisY.mp3", nil];
	
	self.selectedRadio = 1;
	
	self.playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.playPauseButton.backgroundColor = [UIColor clearColor];
	self.playPauseButton.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.playPauseButton.layer.borderWidth = 1.5;
	self.playPauseButton.layer.cornerRadius = 25;
	[self.playPauseButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
	self.playPauseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
	self.playPauseButton.frame = CGRectMake(self.view.frame.size.width/2 - 25, self.view.frame.size.height - 195, 50, 50);
	if(IS_IPHONE6PLUS){
		self.playPauseButton.frame = CGRectMake(self.view.frame.size.width/2 - 25, self.view.frame.size.height - 210, 50, 50);
	}
	[self.playPauseButton addTarget:self action:@selector(togglePlayPause) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.playPauseButton];
	
	STKAudioPlayerOptions options;
	options.enableVolumeMixer = YES;
	options.flushQueueOnSeek = YES;

	self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:options];
	self.audioPlayer.delegate = self;

	self.backRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.backRadioButton.backgroundColor = [UIColor clearColor];
	self.backRadioButton.frame = CGRectMake(0, self.view.frame.size.height - 203, 60, 60);
	if(IS_IPHONE6PLUS){
		self.backRadioButton.frame = CGRectMake(0, self.view.frame.size.height - 213, 60, 60);
	}
	[self.backRadioButton setImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
	[self.backRadioButton addTarget:self action:@selector(goBackRadio) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.backRadioButton];
	
	self.nextRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.nextRadioButton.backgroundColor = [UIColor clearColor];
	[self.nextRadioButton setImage:[UIImage imageNamed:@"Next"] forState:UIControlStateNormal];
	self.nextRadioButton.frame = CGRectMake(self.view.frame.size.width - 65, self.view.frame.size.height - 203, 60, 60);
	if(IS_IPHONE6PLUS){
		self.nextRadioButton.frame = CGRectMake(self.view.frame.size.width - 65, self.view.frame.size.height - 213, 60, 60);
	}
	[self.nextRadioButton addTarget:self action:@selector(nextRadioStation) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.nextRadioButton];

	
	self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
	self.bannerView.frame = CGRectMake(0, self.view.frame.size.height - 98, self.view.frame.size.width, self.bannerView.frame.size.height);
	self.bannerView.adUnitID = @"ca-app-pub-3677742875636291/8598865284";
	self.bannerView.rootViewController = self;
	[self.bannerView setDelegate:self];
	self.bannerView.alpha = 0.0;
	[self.view addSubview:self.bannerView];
	[self.bannerView loadRequest:[GADRequest request]];
	
	self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 240, 50)];
	self.slider.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 120);
	if(IS_IPHONE6PLUS){
		self.slider.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 130);
	}
	self.slider.maximumValue = 1;
	self.slider.minimumValue = 0;
	[self.slider addTarget:self action:@selector(lineSliderDidChange:) forControlEvents:UIControlEventAllTouchEvents];
	self.slider.value = 1;
	
	[self.view addSubview:self.slider];
	
	[self.tabBarItem setImage:[UIImage imageNamed:@"Radio"]];
	
	[self.view bringSubviewToFront:self.tableView];

	// Do any additional setup after loading the view, typically from a nib.
}

-(void)lineSliderDidChange:(UISlider*)slider{
	NSLog(@"%f", slider.value);
	self.audioPlayer.volume = slider.value;
}

-(void)togglePlayPause{
	if(self.playing){
		[self.audioPlayer pause];
		[self.playPauseButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
		self.playPauseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
		self.playing = NO;

	}
	else{
		
		[self.audioPlayer play:self.radioStreams[self.selectedRadio]];
		[self.playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
		self.playPauseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
		self.playing = YES;


	}
}

-(void)nextRadioStation{
	self.selectedRadio++;
	if(self.selectedRadio == 8){
		self.selectedRadio = 0;
	}
	if(self.audioPlayer.state == STKAudioPlayerStatePlaying){
		[self.audioPlayer play:self.radioStreams[self.selectedRadio]];
	}
	[self updateSelectedRadioLabel];
}

-(void)goBackRadio{
	self.selectedRadio--;
	if(self.selectedRadio == -1){
		self.selectedRadio = 7;
	}
	if(self.audioPlayer.state == STKAudioPlayerStatePlaying){
		[self.audioPlayer play:self.radioStreams[self.selectedRadio]];
	}
	[self updateSelectedRadioLabel];

}


-(void)dropDownList{
	
	if(self.tableView.frame.size.height == 0){
		[self.carrot setImage:[UIImage imageNamed:@"Carrot-Up"]];

		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.30];
		[UIView setAnimationDelay:0.0];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		if(IS_IPHONE6 || IS_IPHONE6PLUS){
		self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 390);
		}
		else{
			self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, TABLEVIEWHEIGHT);
		}
		
		
		[UIView commitAnimations];
	}
	else{
		[self.carrot setImage:[UIImage imageNamed:@"Carrot-Down"]];

		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.30];
		[UIView setAnimationDelay:0.0];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		
		self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
		
		[UIView commitAnimations];
	}
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	// If you're serving data from an array, return the length of the array:
	return 8;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	// Set the data for this cell:
	
	NSString *cellText = @"";
	switch(indexPath.row)
	{
		case 0:
			cellText = @"Scanner";
			break;
		case 1:
			cellText = @"Fireground";
			break;
		case 2:
			cellText = @"Manhattan";
			break;
		case 3:
			cellText = @"Brooklyn";
			break;
		case 4:
			cellText = @"Da Bronx";
			break;
		case 5:
			cellText = @"Queens";
			break;
		case 6:
			cellText = @"Staten Island";
			break;
		case 7:
			cellText = @"Citywide";
			break;
		default:
			
			break;
	}
	[cell.textLabel setText:cellText];
	[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0]];
	cell.separatorInset = UIEdgeInsetsZero;
	[cell.textLabel setTextColor:[UIColor colorWithRed:80.0f/255.0f green:136.0f/255.0f blue:187.0f/255.0f alpha:1.0]];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	// set the accessory view:
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	
	if(!self.playing){
		[self.audioPlayer pause];
	}
	
	switch(indexPath.row)
	{
		case 0:
			self.selectedRadio = 0;
			break;
		case 1:
			self.selectedRadio = 1;
			break;
		case 2:
			self.selectedRadio = 2;
			break;
			
		case 3:
			self.selectedRadio = 3;
			break;
			
		case 4:
			self.selectedRadio = 4;
			break;
			
		case 5:
			self.selectedRadio = 5;
			break;
			
		case 6:
			self.selectedRadio = 6;
			break;
		case 7:
			self.selectedRadio = 7;
			break;
		default:
			break;
	}
	
	if(self.playing){
		[self.audioPlayer play:self.radioStreams[self.selectedRadio]];
	}
	
	[self updateSelectedRadioLabel];
	[self.carrot setImage:[UIImage imageNamed:@"Carrot-Down"]];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
	
	[UIView commitAnimations];

}


/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode{
	
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState{

}

-(void)updateSelectedRadioLabel{
	
	switch(self.selectedRadio)
	{
		case 0:
			self.selectedRadioLabel.text = @"Scanner Radio";
			break;
		case 1:
			self.selectedRadioLabel.text = @"Fireground Radio";
			
			break;
		case 2:
			self.selectedRadioLabel.text = @"Manhattan Radio";
			
			break;
			
		case 3:
			self.selectedRadioLabel.text = @"Brooklyn Radio";
			
			break;
			
		case 4:
			self.selectedRadioLabel.text = @"Da Bronx Radio";
			
			break;
		case 5:
			self.selectedRadioLabel.text = @"Queens Radio";
			
			break;
			
		case 6:
			self.selectedRadioLabel.text = @"Staten Island Radio";
			
			break;
			
		case 7:
			self.selectedRadioLabel.text = @"Citywide Radio";
			
			break;
		
		default:
			
			break;
	}
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(IS_IPHONE4){
		return 39.0;
	}
	if(IS_IPHONE6 || IS_IPHONE6PLUS){
		return 49.0;
	}
	return 37.0;
}


- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
	[UIView beginAnimations:@"Bannerfade" context:nil];
	bannerView.alpha = 1.0;
	[UIView setAnimationDuration:.7];
	[UIView commitAnimations];
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
	[UIView beginAnimations:@"Bannerfade" context:nil];
	[UIView setAnimationDuration:.7];
	bannerView.alpha = 0.0;
	[UIView commitAnimations];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}


@end
