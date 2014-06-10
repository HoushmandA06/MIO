//
//  MIOTableViewController.m
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOTableViewController.h"
#import "GLACollectionViewController.h" // collection view for photos
#import "DLAViewController.h"  // draw app, will proxy for signature page
#import "MIOSingleton.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface MIOTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MIOTableViewController
{
    UIBarButtonItem * back;
    UIBarButtonItem * saveData;
    
    UIBarButtonItem * photos;
    UIBarButtonItem * submit;
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



-(void)backToStartNew
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
}

-(void)saveAction
{
//    [self listArchivePath];
    [[MIOSingleton mainData] saveData];
    
    NSLog(@"Save Data Selected");
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    photos = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photos"] style:UIBarButtonItemStylePlain target:self action:@selector(tabSelected:)];
    
    submit = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(tabSelected:)];
    
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [self setToolbarItems:@[flexible, photos, flexible, submit, flexible]];
    self.navigationController.toolbarHidden = NO;
    
    
}

-(void)tabSelected:(UIBarButtonItem *)sender
{
   
    if([sender isEqual:photos])
    {
        NSLog(@"photos selected");
        
        GLACollectionViewController * collectionVC = [[GLACollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
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
    headerLabel.frame = CGRectMake(10, 15, 200, 20);
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor whiteColor];
    
    // need to handle NEW CARPET, WASHER DRYER, KEYS ISSUED WITH YES / NO SEGMENTED CONTROL

    NSString * sectionKey = [MIOSingleton mainData].sectionNames[section];
    headerLabel.text = sectionKey;
    
    UIButton * addRow = [[UIButton alloc] initWithFrame:CGRectMake(615, 10, 30, 30)];
    addRow.layer.cornerRadius = 15;
    [addRow setTitle:@"+" forState:UIControlStateNormal];
    [addRow addTarget:self action:@selector(addItemToArray:) forControlEvents:UIControlEventTouchUpInside];
    addRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    addRow.layer.borderColor = [UIColor whiteColor].CGColor;
    addRow.titleLabel.textAlignment = NSTextAlignmentCenter;
    addRow.showsTouchWhenHighlighted = YES;
    addRow.layer.borderWidth = 1;
    addRow.titleLabel.textColor = [UIColor whiteColor];
    addRow.tag = section;
    
    UIButton * delRow = [[UIButton alloc] initWithFrame:CGRectMake(710, 10, 30, 30)];
    delRow.layer.cornerRadius = 15;
    [delRow setTitle:@"-" forState:UIControlStateNormal];
    delRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [delRow addTarget:self action:@selector(delItemToArray:) forControlEvents:UIControlEventTouchUpInside];
    delRow.layer.borderColor = [UIColor whiteColor].CGColor;
    delRow.showsTouchWhenHighlighted = YES;
    delRow.layer.borderWidth = 1;
    delRow.titleLabel.textColor = [UIColor whiteColor];
    delRow.tag = section;
    
     UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    customView.backgroundColor = BLUE_COLOR
    [customView addSubview:headerLabel];
    [customView addSubview:addRow];
    [customView addSubview:delRow];
    
    
    //  UISegmentedControl * segmentWorkOrder = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Clear", @"Exceptions", nil]];
    //  segmentWorkOrder.frame = CGRectMake(400, 5, 180, 40);
    //  segmentWorkOrder.userInteractionEnabled = NO;
    //  add segment to controls for key sectionKey
    //  switch 0 or 1 based on change of data
    //  segmentWorkOrder.selectedSegmentIndex = 0;
    //  segmentWorkOrder.selectedSegmentIndex = [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionName][@"allClear"] intValue];
    //  segmentWorkOrder.tintColor = GREEN_COLOR;
    //  [segmentWorkOrder addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    //  [customView addSubview:segmentWorkOrder];

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



/*
 ////// will not need this if changing functionality of SEGMENTEDCONTROL
 - (void)valueChanged:(UISegmentedControl *)segment
 {
 
 // segment.tag = section -> sectionName
 sectionName = [MIOSingleton mainData].sectionNames[segment.tag];
 NSLog(@"%i",segment.selectedSegmentIndex);
 // NSLog(@"%ld",(long)segmentedControl.selectedSegmentIndex);
 }
*/



/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [self.tableView reloadData];
     return YES;
}
*/



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
//        [[MIOSingleton mainData].currentResident ] removeListItemAtIndex:indexPath.row];
        
        // [listItems removeObjectIdenticalTo:listItem];
        
//        TDLTableViewCell *cell = (TDLTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        cell.alpha = 0;
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

//        NSString * sectionKey = [MIOSingleton mainData].sectionNames[indexPath];
//        [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"sectionLists"][sectionKey] removeObjectAtIndex:indexPath];
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

 
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
