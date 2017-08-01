//
//  Categories.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/17/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cat;


@interface Categories : NSObject {
    NSMutableArray * allCategories;
    Cat * currentCat;
    int maxLevel;
}

@property (nonatomic,retain) NSMutableArray * allCategories;
@property (nonatomic,retain) Cat * currentCat;
@property (nonatomic,assign) int maxLevel;

+(Categories * ) sharedCategories;
-(void)createCat: (Cat *) catIn;
-(void) processCategories;
-(NSMutableArray *)getCategories:(Cat * )categoryIn;
-(void)processJSONString:(NSMutableData *)jsonString;


@end