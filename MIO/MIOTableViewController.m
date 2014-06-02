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


@interface MIOTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MIOTableViewController
{
    UIBarButtonItem * back;
    UIBarButtonItem * saveData;
    
    UIBarButtonItem * photos;
    UIBarButtonItem * submit;
    
    NSMutableArray *sections;
    
    int numRow;
    
    NSMutableArray * residentItems;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToStartNew)];
    saveData = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData)];
        
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.rightBarButtonItem = saveData;

    sections = [@[@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2,@2] mutableCopy];  // adjust to set amount for 14 fields

        
/*
    residentItems = [@[
  
                     @{   @"pdfData":@"string",
                          @"sigData":@"string",
                          @"adminDetails":
                          [@{
                            @"name": @"string",
                            @"phone":@"string",
                            @"email":@"string",
                            @"property":@"string",
                            @"unit":@"string",
                            @"minMout":@YES,
                            @"date":@"string",
                            @"sectionLists":
                                         [@{
//                                            @"frontEntrance": [@[
//                                                                [@{
//                                                                    @"comment":@"string",
//                                                                    @"cost":@"string",
//                                                                    @"allClear":[NSNumber numberWithBool:YES],
//                                                                    @"image":[@[]mutableCopy]
//                                                                    }
//                                                                 mutableCopy],
//                                                                [@{
//                                                                    @"comment":@"string",
//                                                                    @"cost":@"string",
//                                                                    @"allClear":[NSNumber numberWithBool:YES],
//                                                                    @"image":[@[]mutableCopy]
//                                                                    }
//                                                                 mutableCopy]
//                                                                ] mutableCopy],
//                                             @"livingRoom": [@[
//                                                              [@{
//                                                                 @"comment":@"string",
//                                                                 @"cost":@"string",
//                                                                 @"allClear":[NSNumber numberWithBool:YES],
//                                                                 @"image":[@[]mutableCopy]
//                                                                 }
//                                                               mutableCopy],
//                                                              [@{
//                                                                 @"comment":@"string",
//                                                                 @"cost":@"string",
//                                                                 @"allClear":[NSNumber numberWithBool:YES],
//                                                                 @"image":[@[]mutableCopy]
//                                                                 }
//                                                               mutableCopy]
//                                                              ] mutableCopy],
                                            } mutableCopy]
                            } mutableCopy]
                      }
                     ] mutableCopy];
        
        
        
        NSArray * sectionNames = @[@"Front Entrance",@"Living Room",@"Kitchen",@"Bathroom #1"];
        
        for (NSString * sectionName in sectionNames)
        {
            residentItems[0][@"adminDetails"][@"sectionLists"][sectionName] = [@[] mutableCopy];
            
            for (int i; i < 2; i++)
            {
                NSMutableDictionary * commentDetails = [@{
                                                          @"comment":@"string",
                                                          @"cost":@"string",
                                                          @"allClear":[NSNumber numberWithBool:YES],
                                                          @"image":[@[]mutableCopy]
                                                          } mutableCopy];
                
                [residentItems[0][@"adminDetails"][@"sectionLists"][sectionName] addObject:commentDetails];
            }
        }
*/
        
        
    }
    return self;
}



-(void)backToStartNew
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
}

-(void)saveData
{
    
    NSLog(@"Save Data Selected");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    photos = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photos"] style:UIBarButtonItemStylePlain target:self action:@selector(tabSelected:)];
    
    //  photos = [[UIBarButtonItem alloc] initWithTitle:@"Colors" style:UIBarButtonItemStylePlain target:self action:@selector(tabSelected:)];
    
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

    
    //  colorsIsSelected = [sender.title isEqualToString:@"Colors"];
    //  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [sections count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = [sections[section] intValue];
    
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
    
    switch (section)
    {
        case 0:
            headerLabel.text = @"Front Entrance";
            break;
        case 1:
            headerLabel.text = @"Living Room";
            break;
        case 2:
            headerLabel.text = @"Kitchen";
            break;
        case 3:
            headerLabel.text = @"Bathroom #1";
            break;
        case 4:
            headerLabel.text = @"Bathroom #2";
            break;
        case 5:
            headerLabel.text = @"Bedroom #1";
            break;
        case 6:
            headerLabel.text = @"Bedroom #2";
            break;
        case 7:
            headerLabel.text = @"Bedroom #3";
            break;
        case 8:
            headerLabel.text = @"Rear Entrance";
            break;
        case 9:
            headerLabel.text = @"Air Conditioning";
            break;
        case 10:
            headerLabel.text = @"Heating System";
            break;
        case 11:
            headerLabel.text = @"Patio";
            break;
        case 12:
            headerLabel.text = @"Balcony";
            break;
        case 13:
            headerLabel.text = @"Storage Room";
        default:break;

        // need to handle NEW CARPET, WASHER DRYER, KEYS ISSUED WITH YES / NO SEGMENTED CONTROL
    }
    
    
    UISegmentedControl * segmentWorkOrder = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Clear", @"Exceptions", nil]];
    segmentWorkOrder.frame = CGRectMake(400, 5, 180, 40);
    segmentWorkOrder.selectedSegmentIndex = 0;
    segmentWorkOrder.tintColor = GREEN_COLOR;
    //[segmentWorkOrder addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    

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
    [customView addSubview:segmentWorkOrder];
    [customView addSubview:addRow];
    [customView addSubview:delRow];
    return customView;

}



-(void)addItemToArray:(UIButton *)sender
{
    
    
    int rowCount = [sections[sender.tag] intValue];
    
    sections[sender.tag] = @(rowCount + 1);
    
    [self.tableView reloadData];
    
    
}

- (void)delItemToArray:(UIButton *)sender
{
//    numRow--;
//    [items removeLastObject];
//    [self.tableView reloadData];
    
    // singleton add item to array
    
    int rowCount = [sections[sender.tag] intValue];
    
    sections[sender.tag] = @(rowCount - 1);
    
    [self.tableView reloadData];
    
    
}

-(void)pushVC
{

    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = YES; // gives you preview of chosen photo
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    NSLog(@"Pushed on camera touch");
}

//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *image = (UIImage *) [info objectForKey:
//                                  UIImagePickerControllerOriginalImage];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    //need to added image to singleton
//        
//    }];
//    
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[MIOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
 
    cell.row = indexPath.row;
    cell.section = indexPath.section;
    cell.delegate = self;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

 
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
