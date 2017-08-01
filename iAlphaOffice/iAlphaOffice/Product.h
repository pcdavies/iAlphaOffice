//
//  Product.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Product : NSObject {
    
    NSString *name;
    NSString *costStr;
    NSString *externalUrl;
    NSString *parentCategoryId;
    NSString *listPriceStr;
    NSString *minPriceStr;
    NSString *productId;
    NSString *status;
    NSString *warrantyPeriodMonths;
    NSString *categoryId;
    Boolean inCart;
    
    NSMutableArray *allParentCategoryIds;

    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *costStr;
@property (nonatomic, retain) NSString *externalUrl;
@property (nonatomic, retain) NSString *parentCategoryId;
@property (nonatomic, retain) NSString *listPriceStr;
@property (nonatomic, retain) NSString *warrantyPeriodMonths;
@property (nonatomic, retain) NSString *minPriceStr;
@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, assign) Boolean inCart;
@property (nonatomic, retain) NSMutableArray *allParentCategoryIds;

@end
