//
//  MIOTableViewController.m
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOTableViewController.h"
#import "MIOCollectionViewController.h" // collection view for photos
#import "DLAViewController.h"  // draw app, will proxy for signature page
#import "MIOSingleton.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface MIOTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MIOTableViewController
{
    UIBarButtonItem * back;
    UIBarButtonItem * saveData;
    
    UIBarButtonItem * photos;
    UIBarButtonItem * submit;
    UIBarButtonItem * launchAVC;
    
    NSString * sectionName;
    
    NSMutableDictionary * commentDetails;
    
    int numRow;
    
    NSIndexPath * photoIndexPath;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        // init controls
        
    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToStartNew)];
    
    saveData = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
        
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.rightBarButtonItem = saveData;

    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    

    photos = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photos"] style:UIBarButtonItemStylePlain target:self action:@selector(tabSelected:)];
    
    submit = [[UIBarButtonItem alloc] initWithTitle:@"Screen Shot" style:UIBarButtonItemStylePlain target:self action:@selector(takeAScreenShot)];
    
    launchAVC = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchAVC)];
    
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [self setToolbarItems:@[flexible, photos, flexible, launchAVC, flexible, submit, flexible]];
    self.navigationController.toolbarHidden = NO;
    
    
}


-(void)backToStartNew
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
}

-(void)saveAction
{
 
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    ai.color = BLUE_COLOR;
    ai.frame = CGRectMake(SCREEN_WIDTH-100, 30, 20, 20.0);
    [ai startAnimating];
    [self.navigationController.view addSubview:ai];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,(unsigned long)NULL), ^{
        
        [[MIOSingleton mainData] saveData];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [ai removeFromSuperview];
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Save Successful" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        });
        
    });
    
    
}


-(void)tabSelected:(UIBarButtonItem *)sender
{
   
    if([sender isEqual:photos])
    {
        NSLog(@"photos selected");
        
        MIOCollectionViewController * collectionVC = [[MIOCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [self.navigationController pushViewController:collectionVC animated:NO];
        
    } else
    {
        NSLog(@"submit selected");
        DLAViewController * signatureVC = [[DLAViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:signatureVC animated:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [[[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"] allKeys] count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString * sectionKey = [MIOSingleton mainData].sectionNames[section];

    int rowCount = [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] count];
    NSLog(@"%i",rowCount);
    
    return rowCount;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    headerLabel.frame = CGRectMake(10, 15, 200, 22);
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor whiteColor];
    
    NSString * sectionKey = [MIOSingleton mainData].sectionNames[section];
    headerLabel.text = sectionKey;
    
    UIButton * addRow = [[UIButton alloc] initWithFrame:CGRectMake(612, 6, 40, 40)];
    addRow.layer.cornerRadius = 20;
    [addRow setTitle:@"+" forState:UIControlStateNormal];
    [addRow addTarget:self action:@selector(addItemToArray:) forControlEvents:UIControlEventTouchUpInside];
    addRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    addRow.layer.borderColor = [UIColor whiteColor].CGColor;
    addRow.titleLabel.textAlignment = NSTextAlignmentCenter;
    addRow.layer.borderWidth = 2;
    addRow.titleLabel.textColor = [UIColor whiteColor];
    addRow.tag = section;
    
    UIButton * delRow = [[UIButton alloc] initWithFrame:CGRectMake(707, 6, 40, 40)];
    delRow.layer.cornerRadius = 20;
    [delRow setTitle:@"-" forState:UIControlStateNormal];
    delRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    [delRow addTarget:self action:@selector(delItemToArray:) forControlEvents:UIControlEventTouchUpInside];
    delRow.layer.borderColor = [UIColor whiteColor].CGColor;
    delRow.layer.backgroundColor = [UIColor colorWithRed:0.890f green:0.384f blue:0.431f alpha:1.0f].CGColor;
    delRow.layer.borderWidth = 2;
    delRow.titleLabel.textColor = [UIColor whiteColor];
    delRow.tag = section;
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    customView.backgroundColor = BLUE_COLOR
    [customView addSubview:headerLabel];
    [customView addSubview:addRow];
    [customView addSubview:delRow];


    return customView;
    
}


-(void)refreshCell:(MIOTableViewCell *)cell
{
    
    [self.tableView reloadData];

}


-(void)addItemToArray:(UIButton *)sender
{

// now that row count in sections is no longer determined by sections[sender.tag], adding a row does not work as the singleton is driving row count
// int rowCount = [sections[sender.tag] intValue];
//    NSString * sectionKey = [MIOSingleton mainData].sectionNames[sender.tag];
//    int rowCount = [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] count];

    commentDetails = [@{
                        @"comment":@"",
                        @"cost":@"",
                        @"allClear":[NSNumber numberWithBool:YES],
                        } mutableCopy];

    NSString * sectionKey = [MIOSingleton mainData].sectionNames[sender.tag];
    
    [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] addObject:commentDetails];
   
    [self.tableView reloadData];
    
}

- (void)delItemToArray:(UIButton *)sender
{
    NSString * sectionKey = [MIOSingleton mainData].sectionNames[sender.tag];
    [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] removeLastObject];
    [self.tableView reloadData];
    
    // int rowCount = [sections[sender.tag] intValue];
    // sectionName = [MIOSingleton mainData].sectionNames[sender.tag];
    // sections[sender.tag] = @(rowCount - 1);
}

-(void)pushVCWithCell:(MIOTableViewCell *)cell
{
    photoIndexPath = [self.tableView indexPathForCell:cell];
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; // gives you preview of chosen photo
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    NSLog(@"Pushed on camera touch");
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    
    {
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (editedImage) {imageToSave = editedImage;}
        else {imageToSave = originalImage;}
        
        NSString * sectionKey = [MIOSingleton mainData].sectionNames[photoIndexPath.section];
        
        [[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey][photoIndexPath.row][@"image"] = imageToSave;

    }
      
    [picker dismissViewControllerAnimated:YES completion:NULL];

  
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[MIOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.section = indexPath.section;
    cell.row = indexPath.row;
    cell.delegate = self;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
 
     return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    //    return UITableViewCellEditingStyleInsert;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MIOTableViewCell *cell = (MIOTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.alpha = 0;
        
        NSString * sectionKey = [MIOSingleton mainData].sectionNames[indexPath.section];
        [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)launchAVC
{
    
    NSString * intro = @"MIO report for ";
    NSString * resident = [MIOSingleton mainData].currentResident[@"adminDetails"][@"Resident"];
    NSString * property = [MIOSingleton mainData].currentResident[@"adminDetails"][@"Property"];
    NSString * unit = [MIOSingleton mainData].currentResident[@"adminDetails"][@"Unit#"];
    
    NSArray * stringsArray = @[intro,resident,property,unit];
    
    NSMutableArray * emailArray = [@[]mutableCopy];
    
    for (NSString * emailString in stringsArray)
    {
        if(emailString.length > 0)
        {
            [emailArray addObject:emailString];
        } else
            [emailArray addObject:@"n/a"];
    }
    
    //NSString *joinedString=[NSString stringWithFormat:@"%@ | Resident: %@ | Property: %@ | Unit: %@",intro,resident,property,unit];
    
    //// EMAIL COMPONENTS FOR VC:
    NSString * combinedString = [NSString stringWithFormat:@" %@ | Resident: %@ | Property: %@ | Unit: %@", emailArray[0],emailArray[1],emailArray[2],emailArray[3]];
    
    
    ///// TEST CODE FOR INSERTING SCREEN SHOTS FROM SINGLETON DICTIONARY KEY @"screenShot"
    UIImage * pulledAdminScreenShot = [[MIOSingleton mainData] currentResident][@"screenShot"][@"adminScreenshot"];
    UIImage * pulledCheckList = [[MIOSingleton mainData] currentResident][@"screenShot2"][@"checkListScreenshot"];
    
    
    NSArray * arrayOfActivityItems = [NSArray arrayWithObjects:@"MIO Report:", pulledAdminScreenShot, pulledCheckList, nil];
    
    //// ACTIVITY VC:
    UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems: arrayOfActivityItems applicationActivities:nil];
    [activityVC setValue:combinedString forKey:@"subject"];
    
    [self.navigationController presentViewController:activityVC animated:YES completion:^{
        
    }];

    // Tailor the list of services displayed
    /*
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeMessage,
                                         UIActivityTypeSaveToCameraRoll, UIActivityTypePrint, UIActivityTypePostToWeibo,
                                         UIActivityTypeCopyToPasteboard];
    */
    
}


-(void)takeAScreenShot
{
    
    CGRect origFrame = self.tableView.frame;
    
    CGRect frame = self.tableView.frame;
    frame.size.height = self.tableView.contentSize.height; // self.tableView.frame.size.height
    self.tableView.frame = frame;
    self.tableView.bounds = frame;
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    UIGraphicsBeginImageContextWithOptions(self.tableView.bounds.size, NO, [UIScreen mainScreen].scale);
    else
    UIGraphicsBeginImageContext(self.tableView.bounds.size);

    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

    NSMutableDictionary * checkListScreenshot = [[NSMutableDictionary alloc] init];
    [checkListScreenshot setObject:image forKey:@"checkListScreenshot"];
    [[MIOSingleton mainData] currentResident][@"screenShot2"] = checkListScreenshot;
    NSLog(@"%@",[[[MIOSingleton mainData] currentResident][@"screenShot2"] allKeys]);

    
    self.tableView.frame = origFrame;
    

   
}



@end
