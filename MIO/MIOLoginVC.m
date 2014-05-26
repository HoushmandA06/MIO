//
//  MIOLoginVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOLoginVC.h"
#import "MIOSignUpVC.h"
#import "MIOWelcomeVC.h"
#import "MIONavVC.h"
//// WILL NEED TO ADD PARSE


@interface MIOLoginVC ()

@end

@implementation MIOLoginVC
{
    UILabel * logInTitle;
    UITextField * nameField;
    UITextField * pwField;
    
 }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    self.view.backgroundColor = BLUE_COLOR;
    
    //// WOULD LIKE TO ANIMATE THIS TO "MIO"
    logInTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150, 100, 300, 50)];
    logInTitle.font = [UIFont fontWithName:@"Helvetica" size:50];
    logInTitle.textAlignment = NSTextAlignmentCenter;
    logInTitle.text = @"MoveInOut";
    logInTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:logInTitle];
   
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
    pwField.placeholder = @"Enter password";
    [self.view addSubview:pwField];
    [pwField resignFirstResponder];
    pwField.delegate = self;
        
    UIButton * current = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 350, 200, 200)];
    [current setImage:[UIImage imageNamed:@"currentuser.png"] forState:UIControlStateNormal];
    current.backgroundColor = [UIColor clearColor];
    current.layer.cornerRadius = 40;
    [current addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:current];
        
    UILabel * newUserQuery = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-200, current.frame.origin.y+200, 400, 20)];
    newUserQuery.text = @"Don't have an account? Click below:";
    newUserQuery.textAlignment = NSTextAlignmentCenter;
    newUserQuery.font = [UIFont fontWithName:@"Helvetica" size:20];
    newUserQuery.textColor = [UIColor whiteColor];
    [self.view addSubview:newUserQuery];
        
    UIButton * newUser = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-95, newUserQuery.frame.origin.y+25, 200, 200)];
    [newUser setImage:[UIImage imageNamed:@"newuser.png"] forState:UIControlStateNormal];
    newUser.backgroundColor = [UIColor clearColor];
    newUser.layer.cornerRadius = 40;
    [newUser addTarget:self action:@selector(newUserSignUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newUser];
        
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)]; //added this to getrid of keyboard with a touch on frame outside of the above items
    [self.view addGestureRecognizer:tap];
        
        

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        logInTitle.alpha = 0;
        
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            logInTitle.alpha = 1;
            
        } completion:nil];
    } completion:nil];
    
}

-(void)signIn
{
    //// PARSE CODE FOR TESTING USER NAME AND PW WITH ALERT VIEW REQUIRED HERE
    
    
    
    
    
    //// NAVIGATION; TO BE ADDED TO PARSE LOGIN SUCCESS BLOCK
    
    MIOWelcomeVC  * welcomeVC = [[MIOWelcomeVC alloc] initWithNibName:nil bundle:nil];
    
    MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:welcomeVC];
    
    [self presentViewController:newNavVC animated:NO completion:^{
    }];

}

-(void)newUserSignUp
{
    MIOSignUpVC * newUserSignUp = [[MIOSignUpVC alloc] initWithNibName:nil bundle:nil];
    
    MIONavVC * nc = [[MIONavVC alloc] initWithRootViewController:newUserSignUp];
    
    nc.navigationBar.barTintColor = BLUE_COLOR;
    nc.navigationBar.translucent = NO;
    
    [self presentViewController:nc animated:YES completion:^{
    }];
    
    // will switch views
    
}

-(void)tapScreen // removes keyboard when clicking outside of fields or buttons
{
    [pwField resignFirstResponder];
    [nameField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
