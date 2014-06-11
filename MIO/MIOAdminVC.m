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
#import "MIODatePickerViewController.h"


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
    
    UIButton * showDatePickerVC = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+45, 100, 200, 60)];
    showDatePickerVC.backgroundColor = [UIColor colorWithWhite:0.95 alpha:.65];
    showDatePickerVC.layer.cornerRadius = 10;
    [showDatePickerVC setTitle:@"Choose Date" forState:UIControlStateNormal];
    [showDatePickerVC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showDatePickerVC addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showDatePickerVC];

    
    
    ///// ADMIN SECTION       
    UILabel * adminTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 568, 60)];
    adminTitle.font = [UIFont fontWithName:@"Helvetica" size:35];
    adminTitle.textAlignment = NSTextAlignmentLeft;
    adminTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    adminTitle.text = @"Enter Admin Details:";
    [self.view addSubview:adminTitle];
    
    fieldNames = @[@"Resident", @"Phone", @"Email", @"Property",@"Unit#"];
 

    fields = [@[]mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100,(index * 70)+170,568,60)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.65];
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
        
        
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
 
        [textField resignFirstResponder];
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
    submit = [[UIButton alloc] initWithFrame:CGRectMake(100,860,568,60)];
    submit.backgroundColor = [UIColor colorWithWhite:0.95 alpha:.65];
    submit.layer.cornerRadius = 10;
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    UIBarButtonItem * screenShot = [[UIBarButtonItem alloc] initWithTitle:@"Screen Shot" style:UIBarButtonItemStylePlain target:self action:@selector(takeAScreenShot)];
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:@[flexible, screenShot, flexible]];

    self.navigationController.toolbarHidden = NO;
    
}


-(void)showDatePicker
{
    
    
    
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
    moveDate.minimumDate = [NSDate date];
    moveDate.date = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"];
    // moveDate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // moveDate.layer.borderWidth = 1;
    // moveDate.layer.cornerRadius = 10;
    
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

-(void)takeAScreenShot
{
    
    
    CGRect frame = self.view.frame;
    frame.size.height = self.view.frame.size.height;//the most important line
    self.view.frame = frame;
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.bounds.size);
    
    //    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    //        UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, [UIScreen mainScreen].scale);
    //    else
    //        UIGraphicsBeginImageContext(self.window.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    /*
     if you want to save captured image locally in your app's document directory
     NSData * data = UIImagePNGRepresentation(image);
     
     NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"testImage.png"];
     NSLog(@"Path for Image : %@",imagePath);
     [data writeToFile:imagePath atomically:YES];
     */
}



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
