//
//  SecondViewController.m
//  FDNY
//
//  Created by Gabe Jacobs on 10/27/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

-(id)init{
	
	self.tabBarItem.title = @"Chat";
	[self.tabBarItem setImage:[UIImage imageNamed:@"Chat"]];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45)];
	self.webView.delegate = self;

	
	NSURL *url = [NSURL URLWithString:@"http://www.shoutmix.com/?thebravest"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setValue:@"https://thebravest.com" forHTTPHeaderField: @"Referer"];

	[self.webView setScalesPageToFit:YES];
	[self.webView loadRequest:request];

	//[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.shoutmix.com/?thebravest"]]];
	[self.view addSubview:self.webView];	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType) navigationType
{
	NSDictionary *headers = [request allHTTPHeaderFields];
	BOOL hasReferer = [headers objectForKey:@"Referer"]!=nil;
	if (hasReferer) {
		// .. is this my referer?
		return YES;
	} else {
		// relaunch with a modified request
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			dispatch_async(dispatch_get_main_queue(), ^{
				NSURL *url = [request URL];
				NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
				[request setHTTPMethod:@"GET"];
				[request setValue:@"https://whatever.com" forHTTPHeaderField: @"Referer"];
				[self.webView loadRequest:request];
			});
		});
		return NO;
	}
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end
