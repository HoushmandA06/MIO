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
    
    UIBarButtonItem * back;
    
    NSArray * fieldNames;
    NSMutableArray * fields;
    
    
    
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
 //   UILabel * adminTitle = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    fieldNames = @[@"Resident", @"Phone", @"Email", @"Property",@"Unit #"];
    
    fields = [@[]mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
    
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100,(index * 70)+200,568,60)];
        textField.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
        textField.layer.cornerRadius = 10;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.placeholder = name;
        textField.autocorrectionType = FALSE;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
        [textField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [textField.layer setBorderWidth: 2.0];
        
        [textField resignFirstResponder]; //this is what makes keyboard go away
        
        [fields addObject:textField];
        
        [self.view addSubview:textField];
        
    }

    
    
    
    
    ///// MOVEIN OR MOVEOUT
    
    moveIn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-250,800,150,150)];
    [moveIn setImage:[UIImage imageNamed:@"movein"] forState:UIControlStateNormal];
    [moveIn addTarget:self action:@selector(moveIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveIn];
    
    moveOut = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+100,800,150,150)];
    [moveOut setImage:[UIImage imageNamed:@"moveout"] forState:UIControlStateNormal];
    [moveOut addTarget:self action:@selector(moveOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveOut];

 }









-(void)moveIn
{
    
    NSLog(@"moveIn selected");
    
}


-(void)moveOut
{
    
    NSLog(@"moveOut selected");

    
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
