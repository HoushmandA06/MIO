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
    
    [self loadListItems];  // will show last save, "launch edit saved", will result this method called
    
    self.sectionNames = @[@"Front Entrance",@"Living Room",@"Kitchen",@"Bedroom #1",@"Bedroom #2",@"Bedroom #3",@"Bathroom #1",@"Bathroom #2",@"Rear Entrance",@"Washer/Dryer",@"Patio",@"Balcony",@"HVAC",@"Storage Room"];
        
    if (self.residentItems == nil )  // will show blank template, "launch new" will result in this if true
        {
            
            self.residentItems = [@[] mutableCopy];
            [self addNewResident];
        }
        
    self.currentResident = [self.residentItems lastObject];
        

    }
    return self;
}

- (void)addNewResident
{
 
    [self.residentItems removeAllObjects];

    //// screenShot is a key value for the "Admin page" screenshot. Currently not using, may enable in future.
    
    NSMutableDictionary * newResident = [@{
                                           @"screenShot":[@{}mutableCopy],
                                           @"screenShot2":[@{}mutableCopy],
                                           @"screenShot3":[@{}mutableCopy],
                                           @"sigData":@"",
                                           @"adminDetails":
                                               [@{
                                                  @"Resident": @"",
                                                  @"Phone":@"",
                                                  @"Email":@"",
                                                  @"Property":@"",
                                                  @"Unit#":@"",
                                                  @"minMout":@"",
                                                  @"date":[NSDate date],
                                                  @"sectionLists":
                                                      [@{
                                                         
                                                         } mutableCopy]
                                                  } mutableCopy]
                                           } mutableCopy];
    
    for (NSString * sectionName in self.sectionNames)
    {
        newResident[@"adminDetails"][@"sectionLists"][sectionName] = [@[] mutableCopy];
        
        for (int i = 0; i < 1; i++)
        {
            NSMutableDictionary * commentDetails = [@{
                                                      @"comment":@"",
                                                      @"cost":@"",
                                                      } mutableCopy];
            
            [newResident[@"adminDetails"][@"sectionLists"][sectionName] addObject:commentDetails];
        }
    }
    
    [self.residentItems addObject:newResident];
    
    self.currentResident = newResident;
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


-(NSArray *)allResidentItems
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
    return [documentDirectory stringByAppendingPathComponent:@"residents.data"];
    
}

-(void)loadListItems //to load data from saved
{
    NSString *path = [self listArchivePath];
    
    NSLog(@"%@",path);
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        self.residentItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}





@end
