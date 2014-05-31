//
//  MIOCollectionViewCell.h
//  MIO
//
//  Created by Ali Houshmand on 5/31/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MIOCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) ALAsset * asset;
@property (nonatomic, strong) UIImageView * photoImageView;


@end
