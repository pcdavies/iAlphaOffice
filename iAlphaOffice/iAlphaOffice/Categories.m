//
//  Categories.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/17/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "Categories.h"
#import "Cat.h"
#import "WebConnection.h"
#import "DebugLogger.h"


@implementation Categories

static Categories *shared = nil;

@synthesize currentCat;
@synthesize allCategories;
@synthesize maxLevel;

+(Categories * ) sharedCategories{
    @synchronized(self){
        if (!shared || shared == nil) {
            shared = [[Categories alloc] init];
        } else {
            // [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoriesComplete" object:nil userInfo:nil];
            
        }
    }
    return shared;
}

-(id) init
{
    if ( self = [super init] ) {
        
    }
    
    self.maxLevel = 0;
    
    self.allCategories = [[NSMutableArray alloc] init];
    
    
    WebConnection * webConnection = [WebConnection sharedWebConnection];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processCategories)
                                                 name:@"WebConnectionComplete" object:nil];
    
    NSString *prodUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"CategoryURLKey"];
    NSString *ipPort = [[NSUserDefaults standardUserDefaults] stringForKey:@"IPAddressPortKey"];
    
    
    NSString * urlString = [NSString stringWithFormat:@"http://%@%@", ipPort, prodUrl];
    
    
    // [webConnection getData:@"http://10.146.91.245:7003/AlphaOffice/jersey/AlphaOfficeAccess/getProductCategoriesJSON"];
    [webConnection getData:urlString];
    
    
    return self;
}

-(NSMutableArray *)getCategories:(Cat * )categoryIn
{
    NSMutableArray *rtnCategories = [[NSMutableArray alloc] init];
    
    int nextLevel = 0;
    
    if ( categoryIn != nil) {
       nextLevel = categoryIn.categoryLevel + 1;
    }
    
    for ( Cat * cat in allCategories) {
        
        if ( cat.categoryLevel == nextLevel) {
            // Anything other than the top level, make sure that the you only grab the children
            if ( nextLevel > 0 && categoryIn != nil) {
                if ( [categoryIn.categoryId isEqualToString:cat.parentCategoryId] ){
                    [rtnCategories addObject:cat];
                }
            } else {
                [rtnCategories addObject:cat];
            }
        }
    }
    
    
    return rtnCategories;
    
}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {


-(void)createCat:(Cat *)catIn
{
    

    Cat * cat = [[Cat alloc] init];
    
    if ( catIn.name == nil || [catIn.name isEqualToString:@""] ) catIn.name = @"n/a";
    cat.name = catIn.name;
    
    if ( catIn.categoryId == nil || [catIn.categoryId isEqualToString:@""] ) catIn.categoryId = @"n/a";
    cat.categoryId = catIn.categoryId;
    
    
    cat.categoryLevel = catIn.categoryLevel;
    if ( cat.categoryLevel > self.maxLevel) {
        self.maxLevel = cat.categoryLevel;
    }
    
    if ( catIn.parentCategoryId == nil || [catIn.parentCategoryId isEqualToString:@""] ) catIn.parentCategoryId = @"n/a";
    cat.parentCategoryId = catIn.parentCategoryId;
    
    
    
    [self.allCategories addObject:cat];
}


-(void) processCategories
{
    // NSLog(@"getRetrieverQueryDone called");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WebConnectionComplete" object:nil];
    
    WebConnection * webConnection = [WebConnection sharedWebConnection];
    
    
    //DebugLog(@"Returned Data Length = %lu",[webConnection.webData length]);
    
    if ( [webConnection.webData length] == 0 ) {
        DebugLog(@"No Category Data Found");
        return;
    }
    [self processJSONString:webConnection.webData];
    
}

-(void)processJSONString:(NSMutableData * )jsonStringIn
{

    NSError *error;
    NSMutableDictionary *categoryList = [NSJSONSerialization
                                        JSONObjectWithData:jsonStringIn
                                        options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                        error:&error];
    
    if (error) {
        DebugLog(@"Error %@",[error localizedDescription]);
        
    } else {
        
        
        NSArray *categories = categoryList[@"productCategoryAPI"];
        Cat * cat = [[Cat alloc ] init ];
        for ( NSDictionary *theCat in categories) {
            
            cat.name = theCat[@"categoryName"];
            cat.categoryId = theCat[@"categoryId"];
            
            NSString *tempCategoryLevel = theCat[@"categoryLevel"];
            
            if ( tempCategoryLevel == nil || [tempCategoryLevel isEqualToString:@""]) {
                cat.categoryLevel = 0;
            } else {
                cat.categoryLevel = [tempCategoryLevel intValue];
            }

            cat.parentCategoryId = theCat[@"parentCategoryId"];
            
            [self createCat:cat];
            
        }
        
        
        
    }
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoriesComplete" object:nil userInfo:nil];
    
    
    
}


@end
