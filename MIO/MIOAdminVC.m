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


@interface MIOAdminVC () <UITextFieldDelegate, UIAlertViewDelegate>

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
    
    UIView * datePickerView;
    UITextField * dateDisplay;
    
    
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
    
    [self moveInOutDate];

    
    ///// ADMIN SECTION       
    UILabel * adminTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 568, 60)];
    adminTitle.font = [UIFont fontWithName:@"Helvetica" size:35];
    adminTitle.textAlignment = NSTextAlignmentLeft;
    adminTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    adminTitle.text = @"Admin Details:";
    [self.view addSubview:adminTitle];
    
    fieldNames = @[@"Resident", @"Phone", @"Email", @"Property",@"Unit#"];
 

    fields = [@[]mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100,(index * 70)+170,568,60)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.75];
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
    

    ///// SUBMIT BUTTON
    submit = [[UIButton alloc] initWithFrame:CGRectMake(100,860,568,60)];
    submit.backgroundColor = [UIColor colorWithWhite:0.95 alpha:.65];
    submit.layer.cornerRadius = 10;
    [submit setTitle:@"Launch Checklist" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    

}


-(void)viewWillAppear:(BOOL)animated
{
  
    self.navigationController.toolbarHidden = YES;  
    
    animated = NO;
    
}


-(void)moveInOutDate
{
    
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-270, SCREEN_WIDTH, 270)];
    datePickerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:.50];
    
    
    /////// ITEMS IN SELF.VIEW
    dateDisplay = [[UITextField alloc] initWithFrame:CGRectMake(100, 570, 250, 60)];
    dateDisplay.inputView = datePickerView;
    dateDisplay.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.65];
    dateDisplay.layer.cornerRadius = 10;
    dateDisplay.placeholder = @"Select Date";
    
    if([[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"] != nil)
    {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    dateDisplay.text =  [dateFormat stringFromDate:[[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"]];
    }
    
    
    [dateDisplay setTextAlignment:NSTextAlignmentCenter];
    //  dateDisplay.delegate = self;  // shuts off ability of this textfield to call keyboard
    [self.view addSubview:dateDisplay];
    
    moveDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 520, 200, 60)];
    moveDateLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    moveDateLabel.textAlignment = NSTextAlignmentLeft;
    moveDateLabel.text = @"Move-In Date";
    moveDateLabel.textColor = [UIColor colorWithWhite:0.95 alpha:.90];
    [self.view addSubview:moveDateLabel];
    
    
    /////// ITEMS IN DATEPICKERVIEW
    UIButton * done = [[UIButton alloc] initWithFrame:CGRectMake(568,172,100,40)];
    done.backgroundColor = BLUE_COLOR;
    done.layer.cornerRadius = 8;
    [done setTitle:@"Done" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [done addTarget:self action:@selector(closeDatePickerView) forControlEvents:UIControlEventTouchUpInside];
    [datePickerView addSubview:done];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Move-In", @"Move-Out", nil]];
    segmentedControl.frame = CGRectMake(SCREEN_WIDTH/2+45, 50, 240, 60);
    segmentedControl.selectedSegmentIndex = [[[MIOSingleton mainData] currentResident][@"adminDetails"][@"minMout"] intValue];
    segmentedControl.tintColor = BLUE_COLOR;
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [datePickerView addSubview:segmentedControl];
   
    
    moveDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(100, 50, 240, 60)];
    [moveDate addTarget:self action:@selector(updateDate:) forControlEvents:UIControlEventValueChanged];
    moveDate.datePickerMode = UIDatePickerModeDate;
    moveDate.backgroundColor = [UIColor clearColor];
    moveDate.layer.borderColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0f].CGColor;
    moveDate.layer.borderWidth = 1;
    moveDate.layer.cornerRadius = 5;
    moveDate.alpha = .85;
    moveDate.minimumDate = [NSDate date];
    moveDate.date = [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"];
    [datePickerView addSubview:moveDate];
    
}

-(void)closeDatePickerView
{

     [self.view endEditing:YES];
    
}



-(void)updateDate:(id)sender
{
    NSDate *myDate = moveDate.date;
   
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    dateDisplay.text = [dateFormat stringFromDate:moveDate.date];

    [[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"] = myDate;
    
     NSLog(@"%@ from singleton",[[MIOSingleton mainData] currentResident][@"adminDetails"][@"date"]);
}



- (void)valueChanged:(UISegmentedControl *)segment
{
    
    if(segment.selectedSegmentIndex == 0) {
        moveDateLabel.text = @"Move-In Date";
       
    } else if(segment.selectedSegmentIndex == 1){
        moveDateLabel.text = @"Move-Out Date";
    }
    
    [[MIOSingleton mainData] currentResident][@"adminDetails"][@"minMout"] = [NSNumber numberWithInt:segment.selectedSegmentIndex];
    
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

-(void)takeAScreenShot
{
    
    CGRect frame = self.view.frame;
    frame.size.height = self.view.frame.size.height;
    self.view.frame = frame;
    self.view.bounds = frame;

    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    else
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    NSMutableDictionary * adminScreenshot = [[NSMutableDictionary alloc] init];
    [adminScreenshot setObject:image forKey:@"adminScreenshot"];
    [[MIOSingleton mainData] currentResident][@"screenShot"] = adminScreenshot;

    NSLog(@"%@",[[[MIOSingleton mainData] currentResident][@"screenShot"] allKeys]);
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 }



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    int index = [fields indexOfObject:textField];
    NSString * key = fieldNames[index];
    [[MIOSingleton mainData] currentResident][@"adminDetails"][key] = textField.text;

    
    return YES;
}


@end
