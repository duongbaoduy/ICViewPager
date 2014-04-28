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
}

@end
