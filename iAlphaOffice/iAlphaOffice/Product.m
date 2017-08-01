//
//  Product.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize name;
@synthesize costStr;
@synthesize externalUrl;
@synthesize parentCategoryId;
@synthesize listPriceStr;
@synthesize minPriceStr;
@synthesize productId;
@synthesize status;
@synthesize warrantyPeriodMonths;
@synthesize categoryId;
@synthesize inCart;

@synthesize allParentCategoryIds;


-(id) init
{
    if ( self = [super init] ) {
        
    }
    
    
    self.allParentCategoryIds = [[NSMutableArray alloc] init];
    
    self.inCart = FALSE;
    
    return self;
    
}


@end
