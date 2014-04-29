	//
	//  PageView.m
	//  PagingView
	//
	//  Created by Duong Bao Duy on 4/28/14.
	//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
	//

#import "PageScrollViewController.h"
#include <stdlib.h>
#import "PageViewController.h"


#pragma mark - Constants and macros
#define IOS_VERSION_7 [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending
@interface PageScrollViewController (Private)

@end

@implementation PageScrollViewController

static int numOfPage = 9;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self){
		tabController = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	uiScrollView.delegate = self;
	uiScrollView.alwaysBounceHorizontal = YES;
	uiScrollView.alwaysBounceVertical = NO;
	
	for (int i = 0; i < numOfPage; i++) {
		[tabController addObject:[self createNewController:i]];
	}
	
	uiScrollView.contentSize =
	CGSizeMake(
			   uiScrollView.frame.size.width * numOfPage,
			   uiScrollView.frame.size.height);
	uiScrollView.contentOffset = CGPointMake(0, 0);
}

- (UIViewController *) createNewController: (int) index{
	CGFloat r,g,b;
	PageViewController *controller = [[PageViewController alloc] initWithNibName:@"PageView" bundle:nil];
	
	r = (float) (rand() % 100 +100) / 255;
	g = (float) (rand() % 100 +100) / 255 ;
	b = (float) (rand() % 100 +100) / 255;
	controller.view.backgroundColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
	CGRect pageFrame = uiScrollView.frame;
	pageFrame.origin.y = 0;
	pageFrame.origin.x = uiScrollView.frame.size.width * index;
	controller.view.frame = pageFrame;
	[uiScrollView addSubview:controller.view];
	return controller;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

@end
