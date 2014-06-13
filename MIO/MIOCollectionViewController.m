//
//  GLACollectionViewController.m
//  GridLayout
//
//  Created by Ali Houshmand on 5/30/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//



#import "MIOCollectionViewController.h"
#import "MIOCollectionViewCell.h"
#import "MIODisplayCellVC.h"
#import "MIOSingleton.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>



@interface MIOCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * assets;

@end

@implementation MIOCollectionViewController
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
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        
    UIBarButtonItem * submit = [[UIBarButtonItem alloc] initWithTitle:@"Screen Shot" style:UIBarButtonItemStylePlain target:self action:@selector(takeAScreenShot)];
        
        //tabSelected:
        
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
    [self setToolbarItems:@[flexible, submit, flexible]];
    self.navigationController.toolbarHidden = NO;
    
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
    

//    works with ALA tutorial
//    return self.assets.count;
    

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return CGSizeMake(( SCREEN_WIDTH - 30) / 2.0, (SCREEN_HEIGHT - 30) / 3.0);
    
    
    //3,4
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
 
    
    MIOCollectionViewCell * cell = (MIOCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
   
    MIODisplayCellVC * displayVC = [[MIODisplayCellVC alloc] initWithNibName:nil bundle:nil];
    displayVC.cellImage.image = cell.photoImageView.image;
    displayVC.cellImage.contentMode = UIViewContentModeScaleAspectFit;

    [self.navigationController pushViewController:displayVC animated:NO];
    
    // NSLog(@"did select cell");

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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




-(void)takeAScreenShot
{

    
    CGRect frame = self.collectionView.frame;
    frame.size.height = self.collectionView.contentSize.height;//the most important line
    self.collectionView.frame = frame;
    
    UIGraphicsBeginImageContext(self.collectionView.bounds.size);
    [self.collectionView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    NSMutableDictionary * collectionScreenshot = [[NSMutableDictionary alloc] init];
    [collectionScreenshot setObject:image forKey:@"collectionScreenshot"];
    [[MIOSingleton mainData] currentResident][@"screenShot3"] = collectionScreenshot;
    NSLog(@"%@",[[[MIOSingleton mainData] currentResident][@"screenShot3"] allKeys]);
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
