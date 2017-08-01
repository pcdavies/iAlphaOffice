//
//  Cat.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/17/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cat : NSObject{
    
    
    NSString *name;
    NSString *categoryId;
    int categoryLevel;
    NSString *parentCategoryId;

    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, assign) int categoryLevel;
@property (nonatomic, retain) NSString *parentCategoryId;

@end
