//
//  GLACollectionViewController.m
//  GridLayout
//
//  Created by Ali Houshmand on 5/30/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//



#import "GLACollectionViewController.h"
#import "MIOCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface GLACollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * assets;

@end

@implementation GLACollectionViewController
{
    
    NSMutableArray * imageLabels;
    
}

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if(self)
    {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //might need to be dictionary with key/values for image and image-title; ideally would grab title from TVC section header or comment textfield from cell
        imageLabels = [@[
                   @"Room Label",
                   @"Room Label 2",
                   @"Room Label 3",
                   @"Room Label 4"
                   ]mutableCopy];
    }
    return self;
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   //return [imageLabels count];
   // new code from tutorial
    return self.assets.count;

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(( SCREEN_WIDTH - 30) / 3.0, (SCREEN_HEIGHT - 30) / 4.0);
    
}



-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 2.0;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
    
}


//// possible to build feature where user holds finger on photo (cell) to delete?

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

//modified below per tutorial
   
    MIOCollectionViewCell * cell = (MIOCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    ALAsset * asset = self.assets[indexPath.row];

    cell.asset = asset;
    cell.backgroundColor = [UIColor redColor];
 
    
//// old code
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
    
      return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // had to insert this to get rid of unrecognized selector crash
    [self.collectionView registerClass:[MIOCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];

    
    // new code from tutorial
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    
    // 1
    ALAssetsLibrary *assetsLibrary = [GLACollectionViewController defaultAssetsLibrary];
    // 2
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                // 3
                [tmpAssets addObject:result];
            }
        }];
        
        // 4
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        // 5
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    
    }];
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
