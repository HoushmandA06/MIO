//
//  MIOTableViewCell.m
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOTableViewCell.h"

@implementation MIOTableViewCell
{
    UITextField * comment;

    UITextField * cost;
    
    UIButton * camera;
    
    UISegmentedControl * workOrder;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        comment = [[UITextField alloc] initWithFrame:CGRectMake(0,1,400,40)];
        comment.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
        comment.placeholder = @"comment";
        comment.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        comment.leftViewMode = UITextFieldViewModeAlways;
        comment.autocorrectionType = FALSE;
        comment.delegate = self;
        [self.contentView addSubview:comment];
        
        cost = [[UITextField alloc] initWithFrame:CGRectMake(580,1,100,40)];
        cost.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
        cost.placeholder = @"cost";
        cost.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        cost.leftViewMode = UITextFieldViewModeAlways;
        cost.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cost.autocorrectionType = FALSE;
        comment.delegate = self;
        [self.contentView addSubview:cost];
        
        camera = [[UIButton alloc] initWithFrame:CGRectMake(710, 0, 40, 40)];
        [camera addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [camera setImage:[UIImage imageNamed:@"camera4040"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:camera];
        
    
        
    }
    return self;
}

-(void)selected:(UIButton *)sender
{
    ////how to give each camera a tag to be assigned to a particular comment or section
    
    [sender setSelected:!sender.selected];
    
    NSLog(@"%d %d",self.row,self.section);
    
    // pass position for image picker view to save value
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
