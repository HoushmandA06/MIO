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
    
    NSMutableDictionary * collectionScreenshot;
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
        
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
    collectionScreenshot = [[NSMutableDictionary alloc] init];

        
    [self setToolbarItems:@[flexible, submit, flexible]];
    
    self.navigationController.toolbarHidden = YES;
    
    }
    return self;
}



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
    

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MIOCollectionViewCell * cell = (MIOCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
  
     // cell.backgroundColor = [UIColor colorWithWhite:0.50 alpha:.90];
    
      cell.item = indexPath.item;
      cell.section = indexPath.section;
     

    return cell;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[MIOCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.toolbarHidden = YES;
    
    animated = NO;
}


-(void)takeAScreenShot
{
 
    
    
    CGRect origFrame = self.collectionView.frame;
    
    CGRect frame = self.collectionView.frame;
    frame.size.height = self.collectionView.contentSize.height;//the most important line
    self.collectionView.frame = frame;
    
    UIGraphicsBeginImageContext(self.collectionView.bounds.size);
    [self.collectionView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [collectionScreenshot setObject:image forKey:@"collectionScreenshot"];
    [[MIOSingleton mainData] currentResident][@"screenShot3"] = collectionScreenshot;
    NSLog(@"%@",[[[MIOSingleton mainData] currentResident][@"screenShot3"] allKeys]);
    
    self.collectionView.frame = origFrame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



@end
