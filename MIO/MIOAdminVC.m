//
//  MIOStartNewVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOAdminVC.h"
#import "MIOTableViewController.h"
#import "MIONavVC.h"
#import "MIOSingleton.h"

@interface MIOAdminVC () <UITextFieldDelegate>

@end

@implementation MIOAdminVC
{
 
    UIButton * submit;
    
    UISegmentedControl * segmentedControl;
    
    UIBarButtonItem * back;
    UIBarButtonItem * saveData;
    
    NSArray * fieldNames;
    NSArray * keyboardTypes;
    NSMutableArray * fields;
    
    BOOL moveInIsSelected;
    BOOL moveOutIsSelected;
    
    UILabel * moveDateLabel;
    UIDatePicker * moveDate;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    self.view.backgroundColor = BLUE_COLOR;
    //self.view.backgroundColor = [UIColor clearColor];

    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToWelcome)];
    saveData = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    self.navigationItem.leftBarButtonItem = back;
    self.navigationItem.rightBarButtonItem = saveData;
       
        
           
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///// ADMIN SECTION       
    UILabel * adminTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 568, 60)];
    adminTitle.font = [UIFont fontWithName:@"Helvetica" size:35];
    adminTitle.textAlignment = NSTextAlignmentLeft;
    adminTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    adminTitle.text = @"Enter Admin Details:";
    [self.view addSubview:adminTitle];
    
    fieldNames = @[@"Resident", @"Phone", @"Email", @"Property",@"Unit#"];
 

//    keyboardTypes = @[@(UIKeyboardTypeDefault),@(UIKeyboardTypePhonePad),@(UIKeyboardTypeEmailAddress),@(UIKeyboardTypeNamePhonePad),@(UIKeyboardTypeNumbersAndPunctuation)];

    
    fields = [@[]mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100,(index * 70)+170,568,60)];
        textField.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
        textField.layer.cornerRadius = 10;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.placeholder = name;
        textField.autocorrectionType = FALSE;
        
        NSString * key = fieldNames[index];
        textField.text = [[MIOSingleton mainData] currentResident][@"adminDetails"][key];
        
    
        switch ([fieldNames indexOfObject:name])
        {
            case 0:
                textField.keyboardType = UIKeyboardTypeDefault;
                break;
         
            case 1:
                textField.keyboardType = UIKeyboardTypePhonePad;
                break;
            case 2:
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                break;
            case 3:
                textField.keyboardType = UIKeyboardTypeDefault;
                break;
            case 4:
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                
            default:break;
                
        }
        
//        for (NSString * keyboard in keyboardTypes)
//        {
//            NSInteger index = [keyboardTypes indexOfObject:keyboard];
//            [textField setKeyboardType:keyboardTypes[index]];
//        }
        
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
        [textField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [textField.layer setBorderWidth: 2.0];
        [textField resignFirstResponder]; //this is what makes keyboard go away
        [fields addObject:textField];
        [self.view addSubview:textField];
    }
    
    [self moveInOutDate];
    
    ///// MOVEIN OR MOVEOUT
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Move-In", @"Move-Out", nil]];
    segmentedControl.frame = CGRectMake(100, 570, 250, 75);

    segmentedControl.selectedSegmentIndex = [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"minMout"] intValue];
   
    
    segmentedControl.tintColor = GREEN_COLOR;
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    
    ///// SUBMIT BUTTON
    submit = [[UIButton alloc] initWithFrame:CGRectMake(100,900,568,60)];
    submit.backgroundColor = BLUE_COLOR;
    submit.layer.cornerRadius = 10;
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [submit.layer setBorderWidth: 1.0];
    [submit addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
}

-(void)moveInOutDate
{
    moveDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+45, 520, 200, 60)];
    moveDateLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    moveDateLabel.textAlignment = NSTextAlignmentLeft;
    moveDateLabel.text = @"Move-In Date";

    moveDateLabel.textColor = [UIColor colorWithWhite:0.90 alpha:.90];
    [self.view addSubview:moveDateLabel];
    
    moveDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+45, 570, 240, 60)];
    [moveDate addTarget:self action:@selector(updateDate:) forControlEvents:UIControlEventValueChanged];
    moveDate.datePickerMode = UIDatePickerModeDate;
    moveDate.backgroundColor = [UIColor clearColor];
    moveDate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    moveDate.minimumDate = [NSDate date];
    moveDate.date = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"];
    moveDate.layer.borderWidth = 1;
    moveDate.layer.cornerRadius = 10;
    [self.view addSubview:moveDate];

    
}


-(void)updateDate:(id)sender
{
    NSDate *myDate = moveDate.date;
    
    [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"] = myDate;
    
    
    NSLog(@"%@",myDate);
    NSLog(@"%@ from singleton",[[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"]);
    NSLog(@"spun");
    
 //// will use this code for pretty version of date later
 
//   NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
//   [dateFormat setDateFormat:@"MM-dd-YYYY"];
//   NSString *displayVersion = [dateFormat stringFromDate:myDate];
//   [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"] = displayVersion;

}




- (void)valueChanged:(UISegmentedControl *)segment
{
    
    if(segment.selectedSegmentIndex == 0) {
        moveDateLabel.text = @"Move-In Date";
       
    } else if(segment.selectedSegmentIndex == 1){
        moveDateLabel.text = @"Move-Out Date";
    }
    
    [[MIOSingleton mainData] currentResident][@"adminDetails"][@"minMout"] = [NSNumber numberWithInt:segment.selectedSegmentIndex];
    
    
    NSLog(@"%ld",(long)segmentedControl.selectedSegmentIndex);
}



-(void)selected:(UIButton *)sender
{
    
    [sender setSelected:!sender.selected];
    
    MIOTableViewController  * tableVC = [[MIOTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:tableVC];
    
    [self presentViewController:newNavVC animated:NO completion:^{
    }];

}


-(void)backToWelcome
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


//-(void)saveData  //saves the data
//{
//    NSString *path = [self listArchivePath];
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[[MIOSingleton mainData] currentResident]]; //what we are archiving to, should be same as unarchive
//    [data writeToFile:path options:NSDataWritingAtomic error:nil];
//    
//    if(data !=nil)
//    {
//        NSLog(@"data created");
//        NSUInteger texas = [data length];
//        NSLog(@"%lu",(unsigned long)texas);
//    }
//
//}
//
//-(NSString *)listArchivePath  //finds the path to the data to save
//{
//    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = documentDirectories[0];
//    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
//    
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
    
    
    int index = [fields indexOfObject:textField];
    
    NSString * key = fieldNames[index];
    [[MIOSingleton mainData] currentResident][@"adminDetails"][key] = textField.text;
    
    
    
    return YES;
}


@end
