//
//  DNASingleton.h
//  DataNowApp
//
//  Created by Ali Houshmand on 5/6/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIOSingleton : NSObject


+(MIOSingleton *)mainData;

-(void)addListItem:(NSDictionary *)listItem;
-(void)removeListItem:(NSDictionary *)listItem;
-(void)removeListItemAtIndex:(NSInteger)index;
-(NSArray *)allListItems;




@end
