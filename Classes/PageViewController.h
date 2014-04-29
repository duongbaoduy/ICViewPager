//
//  PageViewController.h
//  PagingView
//
//  Created by Duong Bao Duy on 4/28/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
	IBOutlet  UICollectionView *_collectionView;
//	NSMutableArray *images;
//	/*!
//     operation queue for downloading images in background
//     */
//    NSOperationQueue *imageLoaderOpQueue;
}

@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *imageQueue;
@property (nonatomic, retain) NSOperationQueue *imageLoaderOpQueue;



@end
