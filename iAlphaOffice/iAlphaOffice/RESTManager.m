//
//  RESTManager.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "RESTManager.h"
#import "Products.h"
#import "Product.h"
#import "Categories.h"
#import "Cat.h"

@implementation RESTManager

-(void) getAllProductInfo
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processProducts) name:@"ProductsComplete" object:nil];
    
    
    [Products sharedProducts];
    

    
}

-(void) processProducts
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProductsComplete" object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processCategories) name:@"CategoriesComplete" object:nil];
    

    [Categories sharedCategories];


    

    
}
-(void) processCategories
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CategoriesComplete" object:nil];
    
    
    
    // Record all the parent ID's for a given Category
    for ( Product *prod in [[Products sharedProducts] allProducts]) {
        
        // Save of the main category for this product
        [prod.allParentCategoryIds addObject:prod.categoryId];
        
        // Find all the other parent categories
        
        NSString *tmpCategoryId = prod.parentCategoryId;

        
        for ( int i = [[Categories sharedCategories] maxLevel] ; i >= 0; i-- ) {
            
            
            // NSLog(@"Checking Level %d and Product Category %@",i,tmpCategoryId);

            for ( Cat *cat in [[Categories sharedCategories] allCategories]) {
                
                if ( [cat.categoryId isEqualToString:tmpCategoryId]) {
                    
                    [prod.allParentCategoryIds addObject:tmpCategoryId];
                    tmpCategoryId = cat.parentCategoryId;
                    
                    break;

                }
            }
            
        }
        
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AllProductInfoComplete" object:nil userInfo:nil];


}


@end
