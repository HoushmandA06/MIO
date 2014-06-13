//
//  MIODisplayCellVC.m
//  MIO
//
//  Created by Ali Houshmand on 6/10/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIODisplayCellVC.h"

@interface MIODisplayCellVC ()

@end

@implementation MIODisplayCellVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
        self.cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        self.cellImage.backgroundColor = [UIColor clearColor];   //[UIColor colorWithWhite:0.50 alpha:.90];
        //
        [self.view addSubview:self.cellImage];
        

    
    }

    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];


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
