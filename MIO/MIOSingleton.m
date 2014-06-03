//
//  DNASingleton.m
//  DataNowApp
//
//  Created by Ali Houshmand on 5/6/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "MIOSingleton.h"


@interface MIOSingleton ()

@property (nonatomic) NSMutableArray * residentItems;


@end

@implementation MIOSingleton

+(MIOSingleton *)mainData;

{
    static dispatch_once_t create;
    static MIOSingleton * singleton = nil;
    
    dispatch_once(&create, ^ {
        singleton = [[MIOSingleton alloc] init];
    });
    
    return singleton;
}

-(id) init
{
    self = [super init];
    if(self)
    {
        [self loadListItems];
        
        self.residentItems = [@[
                           
                           @{   @"pdfData":@"string",
                                @"sigData":@"string",
                                @"adminDetails":
                                    [@{
                                       @"Resident": @"string",
                                       @"phone":@"string",
                                       @"email":@"string",
                                       @"property":@"string",
                                       @"unit":@"string",
                                       @"minMout":@YES,
                                       @"date":@"string",
                                       @"sectionLists":
                                           [@{
                                       
                                              } mutableCopy]
                                       } mutableCopy]
                                }
                           ] mutableCopy];
        
        
        
        NSArray * sectionNames = @[@"Front Entrance",@"Living Room",@"Kitchen",@"Bathroom #1",@"Bathroom #2",@"Bedroom #1",@"Bedroom #2",@"Bedroom #3",@"Rear Entrance",@"Air Conditioning",@"Heating Systems",@"Patio",@"Balcony",@"Storage Room"];
        
        for (NSString * sectionName in sectionNames)
        {
            self.residentItems[0][@"adminDetails"][@"sectionLists"][sectionName] = [@[] mutableCopy];
            
            for (int i; i < 2; i++)
            {
                NSMutableDictionary * commentDetails = [@{
                                                          @"comment":@"string",
                                                          @"cost":@"string",
                                                          @"allClear":[NSNumber numberWithBool:YES],
                                                          @"image":[@[]mutableCopy]
                                                          } mutableCopy];
                
                [self.residentItems[0][@"adminDetails"][@"sectionLists"][sectionName] addObject:commentDetails];
            }
        }
        
        
        self.currentResident = self.residentItems[0];
        
    }
    return self;
}



-(void)addResidentItem:(NSMutableDictionary *)residentItem
{
    [self.residentItems addObject:residentItem];
    
    self.currentResident = residentItem;
    
    [self saveData];
}

-(void)removeListItem:(NSDictionary *)listItem
{
    [self.residentItems removeObjectIdenticalTo:listItem];
    [self saveData];
}

-(void)removeListItemAtIndex:(NSInteger)index
{
    [self.residentItems removeObjectAtIndex:index];
    [self saveData];
}


-(NSArray *)allListItems
{
    return [self.residentItems copy];
}

-(void)saveData  //saves the data
{
    NSString *path = [self listArchivePath];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.residentItems]; //what we are archiving to, should be same as unarchive
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
    
}

-(NSString *)listArchivePath  //finds the path to the data to save
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
    
}

-(void)loadListItems //to load data from saved
{
    NSString *path = [self listArchivePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        self.residentItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}





@end
