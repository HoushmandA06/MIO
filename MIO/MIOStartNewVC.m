//
//  MIOStartNewVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOStartNewVC.h"

@interface MIOStartNewVC () <UITextFieldDelegate>

@end

@implementation MIOStartNewVC
{
    UIButton * moveIn;
    
    UIButton * moveOut;
    
    UISegmentedControl * segmentedControl;
    
    UIBarButtonItem * back;
    
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

    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToWelcome)];
 
    self.navigationItem.leftBarButtonItem = back;
        
    }
    return self;
}

-(void)backToWelcome
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
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
    
    fieldNames = @[@"Resident", @"Phone", @"Email", @"Property",@"Unit #"];
 

    keyboardTypes = @[@(UIKeyboardTypeDefault),@(UIKeyboardTypePhonePad),@(UIKeyboardTypeEmailAddress),@(UIKeyboardTypeNamePhonePad),@(UIKeyboardTypeNumbersAndPunctuation)];
    

    
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
    
    moveIn = [[UIButton alloc] initWithFrame:CGRectMake(100,600,150,50)];
    moveIn.backgroundColor = [UIColor lightGrayColor];
    moveIn.layer.cornerRadius = 10;
    [moveIn setTitle:@"Move-In" forState:UIControlStateNormal];
    [moveIn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [moveIn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [moveIn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveIn];
    
    moveOut = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+100,600,150,50)];
    moveOut.backgroundColor = [UIColor lightGrayColor];
    moveOut.layer.cornerRadius = 10;
    [moveOut setTitle:@"Move-Out" forState:UIControlStateNormal];
    [moveOut setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [moveOut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [moveOut addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveOut];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Move-In", @"Move-Out", nil]];
    segmentedControl.frame = CGRectMake(100, 700, 250, 50);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

 }

- (void)valueChanged:(UISegmentedControl *)segment
{
    
    if(segment.selectedSegmentIndex == 0) {
        moveDateLabel.text = @"Move-In Date";
        
    } else if(segment.selectedSegmentIndex == 1){
        moveDateLabel.text = @"Move-Out Date";
        
    }
    
    
}

-(void)moveInOutDate
{
    moveDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 130, 568, 60)];
    moveDateLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    moveDateLabel.textAlignment = NSTextAlignmentLeft;
    moveDateLabel.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:moveDateLabel];

    ///// DATE PICKER
    moveDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 570, 240, 60)];
    moveDate.datePickerMode = UIDatePickerModeDate;
    moveDate.backgroundColor = [UIColor clearColor];
    moveDate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    moveDate.layer.borderWidth = 2;
    moveDate.layer.cornerRadius = 10;
    
    [self.view addSubview:moveDate];
}


-(void)selected:(UIButton *)sender
{
    
    [sender setSelected:!sender.selected];
    
    
    if (moveIn.selected)
    {   moveDateLabel.text = @"Move-In Date";
        moveOut.selected = NO;
    } else if (moveOut.selected)
    {   moveDateLabel.text = @"Move-Out Date";
        moveIn.selected = NO;
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
 
    return YES;
}
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
