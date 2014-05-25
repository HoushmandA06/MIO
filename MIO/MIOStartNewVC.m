//
//  MIOStartNewVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOStartNewVC.h"

@interface MIOStartNewVC () <UITextViewDelegate>

@end

@implementation MIOStartNewVC
{
    UIButton * moveIn;
    
    UIButton * moveOut;
    
    UIBarButtonItem * back;
    
    
    
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




- (BOOL)textViewShouldReturn:(UITextView *)textView   //now any textField will allow resign keyboard
{
    [textView resignFirstResponder];
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
