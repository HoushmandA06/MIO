//
//  MIOCollectionViewCell.m
//  MIO
//
//  Created by Ali Houshmand on 5/31/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOCollectionViewCell.h"

@interface MIOCollectionViewCell()



@end

@implementation MIOCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,104,104)];
        
        [self.contentView addSubview:self.photoImageView];
        
    }
    return self;
}

-(void)setAsset:(ALAsset *)asset
{
    _asset = asset;
 
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
