//
//  FirstViewController.h
//  FDNY
//
//  Created by Gabe Jacobs on 10/27/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <StreamingKit/STKAudioPlayer.h>
#import "TwitterTableView.h"
#import "GADBannerView.h"

@interface FirstViewController : UIViewController <STKAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate>

@property AVAudioPlayer *audioPlyer;
@property UITableView	*tableView;
@property UIButton		*radioChangeButton;
@property UIImageView	*bg;
@property UILabel		*selectedRadioLabel;
@property STKAudioPlayer *audioPlayer;
@property int			selectedRadio;
@property NSArray		*radioStreams;
@property UIButton		*playPauseButton;
@property UIButton		*nextRadioButton;
@property UIButton		*backRadioButton;
@property (nonatomic,strong) GADBannerView *bannerView;
@property (nonatomic,strong) UISlider *slider;
@property BOOL playing;
@property UIImageView	*carrot;

@property TwitterTableView	*twitterTableView;


@end

