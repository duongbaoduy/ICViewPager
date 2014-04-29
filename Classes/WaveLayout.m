//
//  WaveLayout.m
//  PagingView
//
//  Created by Duong Bao Duy on 4/29/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "WaveLayout.h"

@implementation WaveLayout

- (void)prepareLayout {
    self.itemSize = CGSizeMake(75, 500);
    self.minimumInteritemSpacing = 30;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attribs = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attributes in attribs) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distanceFromCenter = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distanceFromCenter / 100.0f;
            CGRect rect = attributes.frame;
            rect.origin.y = sinf(normalizedDistance) * 100.0f + 150.0f;
            attributes.frame = rect;
        }
    }
    
    return attribs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
