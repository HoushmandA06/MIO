//
//  MIOTableViewController.m
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOTableViewController.h"
#import "MIOTableViewCell.h"

@interface MIOTableViewController ()

@end

@implementation MIOTableViewController
{
    UIBarButtonItem * back;
    UIBarButtonItem * saveData;
    
    NSMutableArray *items;
    int num;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToStartNew)];
    saveData = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData)];
        
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

-(void)saveData
{
    
    NSLog(@"Save Data Selected");
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation: (UITableViewRowAnimation)animation;
{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MIOTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[MIOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    //// IS THIS OK?
    items = [[NSMutableArray alloc] initWithObjects:cell, cell, nil];
    
    
    num = 6;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 14;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // Return the number of rows in the section.
    
    return [items count];
    
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
  //  headerLabel.text = @"text";
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
    [addRow addTarget:self action:@selector(addItemToArray) forControlEvents:UIControlEventTouchUpInside];
    addRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    addRow.layer.borderColor = [UIColor whiteColor].CGColor;
    addRow.titleLabel.textAlignment = NSTextAlignmentCenter;
    addRow.showsTouchWhenHighlighted = YES;
    addRow.layer.borderWidth = 1;
    addRow.titleLabel.textColor = [UIColor whiteColor];
    
    UIButton * delRow = [[UIButton alloc] initWithFrame:CGRectMake(710, 10, 30, 30)];
    delRow.layer.cornerRadius = 15;
    [delRow setTitle:@"-" forState:UIControlStateNormal];
    delRow.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [delRow addTarget:self action:@selector(delItemToArray) forControlEvents:UIControlEventTouchUpInside];
    delRow.layer.borderColor = [UIColor whiteColor].CGColor;
    delRow.showsTouchWhenHighlighted = YES;
    delRow.layer.borderWidth = 1;
    delRow.titleLabel.textColor = [UIColor whiteColor];
    
     UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    customView.backgroundColor = BLUE_COLOR
    [customView addSubview:headerLabel];
    [customView addSubview:segmentWorkOrder];
    [customView addSubview:addRow];
    [customView addSubview:delRow];
    return customView;

}



-(void)addItemToArray
{
    
    MIOTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[MIOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    num++;
    [items addObject:cell];
    [self.tableView reloadData];
    
    // [self.tableView reloadData];
    // [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)delItemToArray {
    num--;
    [items removeLastObject];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[MIOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
 
    cell.row = indexPath.row;
    cell.section = indexPath.section;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
