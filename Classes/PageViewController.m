	//
	//  PageViewController.m
	//  PagingView
	//
	//  Created by Duong Bao Duy on 4/28/14.
	//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
	//

#import "PageViewController.h"
#include <stdlib.h>

@interface PageViewController (Private)
- (void) loadImage:(id)arg;
- (void) updateTableView:(id)arg;
@end

@implementation PageViewController

@synthesize images=_images, imageLoaderOpQueue=_imageLoaderOpQueue, imageQueue = _imageQueue;

#pragma mark - override view controller
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self){
		[self initialize];
	}
	return self;
}

- (void)viewDidLoad
{
		//UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
		// _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame];
	[_collectionView setDataSource:self];
	[_collectionView setDelegate:self];
	
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
	_collectionView.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.f];
	
    [self.view addSubview:_collectionView];
	
    [super viewDidLoad];
	
	NSArray *images = [NSArray arrayWithObjects:
					   @"http://api.ning.com/files/1o85jfnBN2mcZIk0YN8L*D-1YJL84E1yTY1YXoonkX-RZZhLfE6t0QA9g09-ObY4oNu5rDQ0roypAcD6VQviQc7EYx7ZHDpn/hotgrilsinfrontcar.jpg?width=64&height=64&crop=1%3A1",
					   //					   @"https://dl.dropboxusercontent.com/u/28830532/060915_CMB_Timeline600nt.jpg",
					   @"http://cdni.condenast.co.uk/128x128/a_c/CCole03_GQ_23Apr12_pr_1920_128x128.jpg",
					   @"http://nandake.com/wp-content/uploads/2011/08/maximgdjihae1-128x128.jpg",
					   @"http://f0.pepst.com/c/3164BA/842307/ssc3/home/033/shahkhan/albums/jessica_alba.jpg_480_480_0_64000_0_1_0.jpg",
					   nil];
	
	[self addImagesToQueue:images];
		//	[images release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
	[_collectionView release];
    [_images release];
	[_imageLoaderOpQueue release];
	[_imageQueue release];
	[super dealloc];
}

#pragma mark - override source data
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 99;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
		//[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
	UICollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
	imgView.autoresizesSubviews = YES;
	NSUInteger aSize = [self.images count];
	if (aSize > 0){
		UIImage *img = [self.images objectAtIndex:(indexPath.row % aSize)];
		if (img) {
			imgView.image = img;
				//			[imgView sizeToFit];
			cell.backgroundColor =[[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.f];
			
		}
	} else {
		float r,g,b;
		r = (float) (rand() % 100 +100) / 255 ;
		g = (float) (rand() % 100 +100) / 255;
		b = (float) (rand() % 100 +100) / 255;
		cell.backgroundColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
	}
	[cell addSubview:imgView];
	return cell;
}



#pragma mark - callback

/*!
 @method
 @abstract   updates tableview for the newly downloaded image and scrolls the tableview to bottom
 */
- (void) updateTableView:(id)arg
{
		//  NSLog(@"AsyncImageLoadingViewController::updateTableView called");
	
    if ((arg == nil) || ([arg isKindOfClass:[UIImage class]] == NO)) {
        return;
    }
		// store the newly downloaded image
    [_images addObject:arg];
    [arg release];
	
		// refresh tableview
    [_collectionView reloadData];
	
		// scroll to the last cell of the tableview
}

/*!
 @method
 @abstract   downloads images, this is the method that dispatches tasks in the operation queue
 */
- (void) loadImage:(id)arg
{
		// NSLog(@"AsyncImageLoadingViewController::loadImage called");
    
    if ((arg == nil) || ([arg isKindOfClass:[NSString class]] == NO)) {
        return;
    }
	
		// create a local autorelease pool since this code runs not on main thread
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
		// fetch the image
		//    NSLog(@"AsyncImageLoadingViewController::loadImage - will download image: %@", arg);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:arg]];
    UIImage *image = [UIImage imageWithData:data];
	
		// update tableview with the downloaded image on main thread
    [self performSelectorOnMainThread:@selector(updateTableView:) withObject:[image retain] waitUntilDone:NO];
	
    [pool release];
	[arg release];
}

#pragma mark - override uicollection delegate


#pragma mark -
#pragma mark Private Methods

/*!
 @method
 @abstract   initializes class variables
 */
- (void) initialize
{
		//NSLog(@"AsyncImageLoadingViewController::initialize called");
	
    NSMutableArray *a = [[NSMutableArray alloc] init];
    a = [[NSMutableArray alloc] init];
    self.images = a;
    [a release];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    self.imageLoaderOpQueue = queue;
    [queue release];
	
	self.imageQueue = [[NSMutableArray alloc] init];
}

/*!
 @method
 @abstract   adds images to the queue and starts the operation queue to download them
 */
- (void) addImagesToQueue:(NSArray *)images
{
		//    NSLog(@"AsyncImageLoadingViewController::addImagesToQueue called");
	
	[_imageQueue addObjectsFromArray:images];
		// suspend the operation queue
    [self.imageLoaderOpQueue setSuspended:YES];
	
		// add tasks to the operation queue
    for (NSString *imageUrl in _imageQueue) {
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                         selector:@selector(loadImage:)
                                                                           object:imageUrl];
        [self.imageLoaderOpQueue addOperation:op];
        [op release];
    }
	
		// clear items in the queue and resume the operation queue to start downloading images
    [self.imageLoaderOpQueue setSuspended:NO];
	[_imageQueue removeAllObjects];
}

@end
