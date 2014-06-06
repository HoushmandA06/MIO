//
//  MIOTableViewCell.h
//  MIO
//
//  Created by Ali Houshmand on 5/27/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MIOTableViewCellDelegate;

@interface MIOTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic,assign) id<MIOTableViewCellDelegate> delegate;


@property (nonatomic) NSDictionary * commentItem;

@property (nonatomic) int row;
@property (nonatomic) int section;

@end

@protocol MIOTableViewCellDelegate <NSObject>

-(void)pushVCWithCell:(MIOTableViewCell *)cell;


@end
