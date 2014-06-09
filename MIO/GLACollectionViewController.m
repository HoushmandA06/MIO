//
//  GLACollectionViewController.m
//  GridLayout
//
//  Created by Ali Houshmand on 5/30/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//



#import "GLACollectionViewController.h"
#import "MIOCollectionViewCell.h"
#import "MIOSingleton.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface GLACollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * assets;

@end

@implementation GLACollectionViewController
{
    
    
}

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if(self)
    {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        

    
    }
    return self;
}

//+ (ALAssetsLibrary *)defaultAssetsLibrary
//{
//    static dispatch_once_t pred = 0;
//    static ALAssetsLibrary *library = nil;
//    dispatch_once(&pred, ^{
//        library = [[ALAssetsLibrary alloc] init];
//    });
//    return library;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     
    return [[[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"] allKeys] count];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSString * sectionKey = [MIOSingleton mainData].sectionNames[section];
    
    int itemsCount = 0;
    
    NSArray * items = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey];
    
    for (NSDictionary * item in items)
    {
        if (item[@"image"]) itemsCount++;
    }
    
    return itemsCount;
    

// works with ALA tutorial
//    return self.assets.count;
    

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return CGSizeMake(( SCREEN_WIDTH - 30) / 3.0, (SCREEN_HEIGHT - 30) / 4.0);
    
}



-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 4.0;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10.0;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSLog(@"did select cell");
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MIOCollectionViewCell * cell = (MIOCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
  
////  modified below per tutorial
//    ALAsset * asset = self.assets[indexPath.row];
//    cell.asset = asset;
    
      cell.backgroundColor = [UIColor colorWithWhite:0.50 alpha:.90];
    
      cell.item = indexPath.item;
      cell.section = indexPath.section;
      cell.layer.cornerRadius = 5;
      [cell.layer setBorderWidth:1];
      [cell.layer setBorderColor:[UIColor lightGrayColor].CGColor];

    
////  non ALA code
//    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-20, 20)];
//    
//    title.textColor = [UIColor colorWithWhite:.90 alpha:.90];
//    
//    title.text = imageLabels[indexPath.row];
//    
//    [cell.contentView addSubview:title];
//    
//    cell.backgroundColor = [UIColor lightGrayColor];
//    
//    cell.layer.cornerRadius = 10;
//
//
//    NSString * sectionName = [MIOSingleton mainData].sectionNames[cell.section];
//
//    cell.photoImageView = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionName][@"image"];
//

    return cell;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // had to insert this to get rid of unrecognized selector crash
    [self.collectionView registerClass:[MIOCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];

    
    // new code from tutorial
//    _assets = [@[] mutableCopy];
//    __block NSMutableArray * tmpAssets = [@[] mutableCopy];
//    
//    // 1
//    ALAssetsLibrary *assetsLibrary = [GLACollectionViewController defaultAssetsLibrary];
//    // 2
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            if(result)
//            {
//                // 3
//                [tmpAssets addObject:result];
//            }
//        }];
//        
//        // 4
//        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
//        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
//        self.assets = tmpAssets;
//        
//        // 5
//        [self.collectionView reloadData];
//    } failureBlock:^(NSError *error) {
//        NSLog(@"Error loading images %@", error);
//    
//    }];
    
 

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
