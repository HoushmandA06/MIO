//
//  DNASingleton.h
//  DataNowApp
//
//  Created by Ali Houshmand on 5/6/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIOSingleton : NSObject

@property (nonatomic) NSMutableDictionary * currentResident;
@property (nonatomic) NSArray * sectionNames;

+(MIOSingleton *)mainData;


-(void)addResidentItem:(NSMutableDictionary *)residentItem;

-(void)removeListItem:(NSDictionary *)listItem;
-(void)removeListItemAtIndex:(NSInteger)index;
-(NSArray *)allListItems;

 


@end
