//
//  MIOWelcomeVC.m
//  MoveInOut
//
//  Created by Ali Houshmand on 5/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOWelcomeVC.h"
#import "MIOAdminVC.h"
#import "MIONavVC.h"
#import "MIOSingleton.h"

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

        welcomeTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-305, 900, 600, 85)];
        welcomeTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:75];
        welcomeTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:welcomeTitle];
        
        back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToLogIn)];
        
        self.navigationItem.leftBarButtonItem = back;
        
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        backgroundImage.contentMode = UIViewContentModeScaleToFill;     
        [backgroundImage setImage:[UIImage imageNamed:@"launch.png"]];
        
        [self.view addSubview:backgroundImage];
        [self.view sendSubviewToBack:backgroundImage];
        
        
        
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
    
    startNew = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-250, 580, 150, 150)];
    [startNew setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    startNew.backgroundColor = [UIColor colorWithWhite:0.95 alpha:.60];
    startNew.layer.cornerRadius = 75;
    [startNew addTarget:self action:@selector(launchStartNew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startNew];
    
    editSaved = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)+90, 580, 150, 150)];
    [editSaved setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    editSaved.backgroundColor = [UIColor colorWithWhite:0.95 alpha:.60];
    editSaved.layer.cornerRadius = 75;
    [editSaved addTarget:self action:@selector(launchEditSaved) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editSaved];
    
    UILabel * startNewFile = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-250+45, 720, 300, 50)];
    startNewFile.text = @"new";
    startNewFile.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
    startNewFile.textColor = [UIColor lightTextColor];
    [self.view addSubview:startNewFile];
    
    UILabel * editLastSaved = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)+90, 720, 300, 50)];
    editLastSaved.text = @"edit previous";
    editLastSaved.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
    editLastSaved.textColor = [UIColor lightTextColor];
    [self.view addSubview:editLastSaved];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    welcomeTitle.textColor = [UIColor lightTextColor];
    welcomeTitle.text = @"Welcome";
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        welcomeTitle.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        welcomeTitle.textColor = BLUE_COLOR;
        welcomeTitle.text =  [[UIDevice currentDevice] name];
        
       
        
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
        welcomeTitle.alpha = 1;
            
    } completion:nil];
        
    }];
    
}



- (void)alertView:(UIAlertView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
 
    if (buttonIndex == 0)
    {
        [[MIOSingleton mainData] addNewResident];

        
        MIOAdminVC  * adminVC = [[MIOAdminVC alloc] initWithNibName:nil bundle:nil];
        
        MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:adminVC];
        [self presentViewController:newNavVC animated:NO completion:^{
        }];
    }
    else
    {
        NSLog(@"cancel");
    }
}


-(void)launchStartNew
{
    

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"A new MIO will erase last saved, continue?" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];

    [alertView show];
    

//    [[MIOSingleton mainData] addNewResident];
//    
//    MIOAdminVC  * adminVC = [[MIOAdminVC alloc] initWithNibName:nil bundle:nil];
//    
//    MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:adminVC];
//    [self presentViewController:newNavVC animated:NO completion:^{
//    }];

}

-(void)launchEditSaved
{
    
    NSLog(@"%lu",(unsigned long)[[[MIOSingleton mainData] allResidentItems] count]);
    NSLog(@"%@",[[MIOSingleton mainData] allResidentItems]);
    
    

    
    MIOAdminVC  * adminVC = [[MIOAdminVC alloc] initWithNibName:nil bundle:nil];
    
    MIONavVC * newNavVC = [[MIONavVC alloc] initWithRootViewController:adminVC];
    [self presentViewController:newNavVC animated:NO completion:^{
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
