//
//  MIOTableViewCell.m
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOTableViewCell.h"
#import "MIOCameraVC.h"


@implementation MIOTableViewCell
{
    UITextField * comment;

    UITextField * cost;
    
    UIButton * camera;
    
    UISegmentedControl * workOrder;
    
    
        //// WILL NEED A UIBUTTON TO PUSH A COLLECTION VIEW IF CAMERA USED TO TAKE PIC (PUSH/POP)
    
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
        cost.delegate = self;
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
    
    [self.delegate pushVC];
        
    // pass position for image picker view to save value
    
}

- (void)setRow:(int)row
{
    _row = row;
    
    // update comment.text = somthing based on _row / _section
    
//    NSString * sectionKey = [data allKeys][self.section];
//    
//    NSArray * rows = data[sectionKey];
//    
//    NSDictionary * rowData = rows[row];
//    
//    
//    comment.text = rowData[@"comment"];
//    cost.text = rowData[@"cost"];
}

- (void)setSection:(int)section
{
    
    _section = section;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    // save comment.text to something based on self.row / self.section
    
//    NSString * sectionKey = [data allKeys][self.section];
//    
//    NSMutableArray * rows = data[sectionKey];
//    
//    [rows removeObjectAtIndex:self.row];
//    
//    NSMutableDictionary * rowData = rows[self.row];
//    
//    // needs to be parse or singleton
//    rowData[@"comment"] = comment.text;
//    rowData[@"cost"] = cost.text;
    
    
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
