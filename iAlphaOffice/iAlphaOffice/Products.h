//
//  Products.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//
#import <Foundation/Foundation.h>

@class Product;
@class Cat;

@interface Products : NSObject {
    NSMutableArray * allProducts;
    Product * currentProduct;
}

@property (nonatomic,retain) NSMutableArray * allProducts;
@property (nonatomic,retain) Product * currentProduct;

+(Products * ) sharedProducts;
-(void)processJSONString:(NSMutableData *)jsonString;
-(void)createProduct: (Product *) productIn;
-(void) processProducts;
-(NSMutableArray *)getProducts:(Cat * )categoryIn;
-(void)addProductToCart:(Product *)productIn;
-(void)removeProductFromCart:(Product *)productIn;
-(int)productsInCart;
-(Boolean)isProductInCart:(Product *)productIn;
-(NSMutableArray *)getProductsInCart;
-(void)clearCart;


@end