//
//  MIOCollectionViewCell.m
//  MIO
//
//  Created by Ali Houshmand on 5/31/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOCollectionViewCell.h"
#import "MIOSingleton.h"


@interface MIOCollectionViewCell()



@end

@implementation MIOCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,25,350,290)];
       
        self.labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10,295,180,20)];
        self.labelComment.textColor = [UIColor whiteColor];
        
        self.labelSection = [[UILabel alloc] initWithFrame:CGRectMake(10,5,180,20)];
        self.labelSection.textColor = [UIColor blackColor];
        
        
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.labelComment];
        [self.contentView addSubview:self.labelSection];
        
    }
    return self;
}

//-(void)setAsset:(ALAsset *)asset
//{
//    _asset = asset;
//    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
//
//}

- (void)setSection:(int)section
{
    _section = section;
    
    NSString * sectionName = [MIOSingleton mainData].sectionNames[_section];
    
    NSArray * items = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionName];
    
    NSMutableArray * itemsWithImages = [@[] mutableCopy];
    
    for (NSDictionary * item in items)
    {
        if (item[@"image"]) [itemsWithImages addObject:item];
    }
        
    self.photoImageView.image = itemsWithImages[_item][@"image"];
    self.labelComment.text = itemsWithImages[_item][@"comment"];
    self.labelSection.text = [MIOSingleton mainData].sectionNames[_section];

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
