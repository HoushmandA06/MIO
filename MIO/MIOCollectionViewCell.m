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

        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,1,350,309)];
       
        
        UILabel * labelSectionInset = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 10, 19)];
        labelSectionInset.backgroundColor = [UIColor blackColor];
        labelSectionInset.alpha = .40;
        
        self.labelSection = [[UILabel alloc] initWithFrame:CGRectMake(20,1,340,19)];
        self.labelSection.textColor = [UIColor whiteColor];
        self.labelSection.backgroundColor = [UIColor blackColor];
        self.labelSection.alpha = .40;
        
        UILabel * labelCommentInset = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, 10, 20)];
        labelCommentInset.backgroundColor = [UIColor blackColor];
        labelCommentInset.alpha = .40;

        self.labelComment = [[UILabel alloc] initWithFrame:CGRectMake(20,290,340,20)];
        self.labelComment.textColor = [UIColor whiteColor];
         self.labelComment.backgroundColor = [UIColor blackColor];
        self.labelComment.alpha = .40;
        
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.labelComment];
        [self.contentView addSubview:self.labelSection];
       
        [self.contentView addSubview:labelSectionInset];
        [self.contentView addSubview:labelCommentInset];


        
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





@end
