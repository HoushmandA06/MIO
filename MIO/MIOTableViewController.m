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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     // Return the number of sections.
    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // Return the number of rows in the section.
    
    
    return 6;
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
            headerLabel.text = @"Bedroom #3";
            break;
            
        case 7:
            headerLabel.text = @"Rear Entrance";
            break;
            
        case 8:
            headerLabel.text = @"Air Conditioning System";
            break;
            
        case 9:
            headerLabel.text = @"Heating System";
            break;
            
        case 10:
            headerLabel.text = @"Patio";
            break;
            
        case 11:
            headerLabel.text = @"Balcony";
            break;
            
        case 12:
            headerLabel.text = @"Storage Room";
            
        default:break;

        // need to handle NEW CARPET, WASHER DRYER, KEYS ISSUED WITH YES / NO SEGMENTED CONTROL
    }
    
    
    UISegmentedControl * segmentWorkOrder = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Clear", @"Exceptions", nil]];
    segmentWorkOrder.frame = CGRectMake(400, 5, 180, 40);
    segmentWorkOrder.selectedSegmentIndex = 0;
    segmentWorkOrder.tintColor = GREEN_COLOR;
    //[segmentWorkOrder addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    customView.backgroundColor = BLUE_COLOR
    [customView addSubview:headerLabel];
    [customView addSubview:segmentWorkOrder];
    return customView;
    
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
// Override to support editing the table view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
