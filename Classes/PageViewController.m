//
//  PageViewController.m
//  PagingView
//
//  Created by Duong Bao Duy on 4/28/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "PageViewController.h"
#include <stdlib.h>

@interface PageViewController ()

@end

@implementation PageViewController

#pragma mark - override view controller
- (void)viewDidLoad
{
		//UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
//    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
//    [_collectionView setDataSource:self];
//    [_collectionView setDelegate:self];
//	
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
		// [_collectionView setBackgroundColor:[UIColor redColor]];
	
    [self.view addSubview:_collectionView];
	
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - override source data
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 99;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
		//[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
	UICollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
	float r,g,b;
	r = (float) (rand() % 100 +100) / 255 ;
	g = (float) (rand() % 100 +100) / 255;
	b = (float) (rand() % 100 +100) / 255;
    cell.backgroundColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
	return cell;
}


#pragma mark - override uicollection delegate

@end
