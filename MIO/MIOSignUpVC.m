//
//  MIOSignUpVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOSignUpVC.h"

@interface MIOSignUpVC ()

@end

@implementation MIOSignUpVC
{
   
    UIBarButtonItem * back;
    UIBarButtonItem * submit;

    UITextField * nameField;
    UITextField * pwField;
    UITextField * pwConfirm;
    UITextField * email;
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    self.view.backgroundColor = [UIColor whiteColor];
    
    
        
        
    back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToLogIn)];
    self.navigationItem.leftBarButtonItem = back;
    back.tintColor = [UIColor whiteColor];
        
    submit = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = submit;
    submit.tintColor = [UIColor whiteColor];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel * adminTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 400, 60)];
    adminTitle.font = [UIFont fontWithName:@"Helvetica" size:35];
    adminTitle.textAlignment = NSTextAlignmentLeft;
    adminTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    adminTitle.text = @"New User Sign-Up:";
    [self.view addSubview:adminTitle];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150,200,300,50)];
    nameField.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
    nameField.layer.cornerRadius = 10;
    nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.placeholder = @"Enter username";
    nameField.autocorrectionType = FALSE;
    nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [nameField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [nameField.layer setBorderWidth: 2.0];
    [self.view addSubview:nameField];
    [nameField resignFirstResponder]; //this is what makes keyboard go away
    nameField.delegate = self;
    
    pwField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150,300,300,50)];
    pwField.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
    pwField.layer.cornerRadius = 10;
    pwField.secureTextEntry = YES;
    pwField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    pwField.leftViewMode = UITextFieldViewModeAlways;
    [pwField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [pwField.layer setBorderWidth: 2.0];
    pwField.placeholder = @"Confirm password";    //// HOW TO TEST
    [self.view addSubview:pwField];
    [pwField resignFirstResponder];
    pwField.delegate = self;
    
    
    pwConfirm = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150,400,300,50)];
    pwConfirm.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
    pwConfirm.layer.cornerRadius = 10;
    pwConfirm.secureTextEntry = YES;
    pwConfirm.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    pwConfirm.leftViewMode = UITextFieldViewModeAlways;
    [pwConfirm.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [pwConfirm.layer setBorderWidth: 2.0];
    pwConfirm.placeholder = @"Enter password";
    [self.view addSubview:pwConfirm];
    [pwConfirm resignFirstResponder];
    pwConfirm.delegate = self;
    
    email = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150,500,300,50)];
    email.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
    email.layer.cornerRadius = 10;
    email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    email.leftViewMode = UITextFieldViewModeAlways;
    email.placeholder = @"Enter email";
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.autocorrectionType = FALSE;
    email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [email.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [email.layer setBorderWidth: 2.0];
    [self.view addSubview:email];
    [email resignFirstResponder]; //this is what makes keyboard go away
    email.delegate = self;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
    
}


-(void)backToLogIn
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
}

-(void)submit
{
    //// NEED TO CONNECT TO PARSE
    
    
    NSLog(@"Submit selected");
    
    
    
}

-(void)tapScreen
{
    
    [pwField resignFirstResponder];
    [nameField resignFirstResponder];
    [pwConfirm resignFirstResponder];
    [email resignFirstResponder];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 }



@end
