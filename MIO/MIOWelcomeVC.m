//
//  MIOWelcomeVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOWelcomeVC.h"
#import "MIOStartNewVC.h"
#import "MIONavVC.h"

@interface MIOWelcomeVC ()

@end

@implementation MIOWelcomeVC
{

    UIButton * startNew;
    UIButton * editSaved;
    UIBarButtonItem * back;
    UILabel * welcomeTitle;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
        self.view.backgroundColor = BLUE_COLOR;

        welcomeTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-150, 100, 300, 50)];
        welcomeTitle.font = [UIFont fontWithName:@"Helvetica" size:50];
        welcomeTitle.text = @"Welcome";
        welcomeTitle.textAlignment = NSTextAlignmentCenter;
        welcomeTitle.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [self.view addSubview:welcomeTitle];
        
        back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToLogIn)];
        
        self.navigationItem.leftBarButtonItem = back;
    
    }
    return self;
}


-(void)backToLogIn
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    startNew = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-75, 250, 150, 150)];
    [startNew setImage:[UIImage imageNamed:@"new"] forState:UIControlStateNormal];
    [startNew addTarget:self action:@selector(launchStartNew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startNew];
    
    editSaved = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-120, 500, 220, 220)];
    [editSaved setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
    [editSaved addTarget:self action:@selector(launchEditSaved) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editSaved];
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        welcomeTitle.alpha = 0;
        
        
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        welcomeTitle.alpha = 1;
            
        } completion:nil];
    } completion:nil];
    
}


-(void)launchStartNew
{
    
    NSLog(@"launching StartNew");
    MIOStartNewVC  * startNewVC = [[MIOStartNewVC alloc] initWithNibName:nil bundle:nil];
    
    MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:startNewVC];
    
    [self presentViewController:newNavVC animated:NO completion:^{
    }];
    
    
    
    
}

-(void)launchEditSaved
{
    
    NSLog(@"launching EditSaved");
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
