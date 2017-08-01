//
//  Products.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "Products.h"
#import "Product.h"
#import "WebConnection.h"
#import "DebugLogger.h"
#import "Cat.h"

@implementation Products

static Products *shared = nil;

@synthesize currentProduct;
@synthesize allProducts;

+(Products *)sharedProducts{
    @synchronized(self){
        if (!shared || shared == nil) {
            shared = [[Products alloc] init];
        } else {
            // [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductsComplete" object:nil userInfo:nil];

        }
    }
    return shared;
}

-(id) init
{
    if ( self = [super init] ) {
        
    }
    
    
    self.allProducts = [[NSMutableArray alloc] init];
    
    
    
    
    
    WebConnection * webConnection = [WebConnection sharedWebConnection];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processProducts)
                                                 name:@"WebConnectionComplete" object:nil];
    
    
    NSString *prodUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"ProductURLKey"];
    NSString *ipPort = [[NSUserDefaults standardUserDefaults] stringForKey:@"IPAddressPortKey"];
    
    
    NSString * urlString = [NSString stringWithFormat:@"http://%@%@", ipPort, prodUrl];
    
    //NSLog(@"!!!!Using this URL %@",urlString);
    
    
    
    
    // [webConnection getData:@"http://10.146.91.245:7003/AlphaOffice/jersey/AlphaOfficeAccess/getProductsJSON"];
    [webConnection getData:urlString];
    
  
    return self;
}


-(NSMutableArray *)getProducts:(Cat * )categoryIn
{
    
    NSMutableArray *rtnProducts = [[NSMutableArray alloc] init];
    

    for ( Product * prod in allProducts ) {
    
        if ( categoryIn == nil ) {
            [rtnProducts addObject:prod];
            
        }
        else {
            for ( NSString * catId in prod.allParentCategoryIds) {
                
                if ( [categoryIn.categoryId isEqualToString:catId]) {
                    [rtnProducts addObject:prod];
                    break;
                }
               
            }
        }
    }
    
    return rtnProducts;
    
}

-(NSMutableArray *)getProductsInCart
{
    
    NSMutableArray *rtnProducts = [[NSMutableArray alloc] init];
    
    
    for ( Product * prod in allProducts ) {
        
        if ( prod.inCart ) {
            
            [rtnProducts addObject:prod];
            
        }
    }
    
    return rtnProducts;
    
}




-(void)createProduct:(Product *)productIn
{
    Product * prod = [[Product alloc] init];
    if ( productIn.name == nil || [productIn.name isEqualToString:@""] ) productIn.name = @"n/a";
    prod.name = productIn.name;
    
    if ( productIn.costStr == nil || [productIn.costStr isEqualToString:@""] ) productIn.costStr = @"0.00";
    prod.costStr = productIn.costStr;
    
    if ( productIn.externalUrl == nil || [productIn.externalUrl isEqualToString:@""] )
    {
        productIn.externalUrl = @"n/a" ;
    } else {
        NSRange substringRange = [productIn.externalUrl rangeOfString:@"/" options:NSBackwardsSearch];
        //NSLog(@"\nLocation = %lu, length = %lu, end=%@",substringRange.location,substringRange.length,
        //      [productIn.externalUrl substringFromIndex:substringRange.location + substringRange.length]);
        
        if ( substringRange.location != NSNotFound ) {
            productIn.externalUrl = [productIn.externalUrl substringFromIndex:substringRange.location + substringRange.length];
        }
        
    }
    prod.externalUrl = productIn.externalUrl;
    
    if ( productIn.categoryId == nil || [productIn.categoryId isEqualToString:@""] ) productIn.categoryId = @"n/a";
    prod.categoryId = productIn.categoryId;
    
    if ( productIn.parentCategoryId == nil || [productIn.parentCategoryId isEqualToString:@""] ) productIn.parentCategoryId = @"n/a";
    prod.parentCategoryId = productIn.parentCategoryId;
    
    if ( productIn.listPriceStr == nil || [productIn.listPriceStr isEqualToString:@""] ) productIn.listPriceStr = @"0.00";
    prod.listPriceStr = productIn.listPriceStr;
    
    if ( productIn.minPriceStr == nil || [productIn.minPriceStr isEqualToString:@""] ) productIn.minPriceStr = @"0.00";
    prod.minPriceStr = productIn.minPriceStr;
    
    if ( productIn.warrantyPeriodMonths == nil || [productIn.warrantyPeriodMonths isEqualToString:@""] ) productIn.warrantyPeriodMonths = @"0";
    prod.warrantyPeriodMonths = productIn.warrantyPeriodMonths;
    
    
    if ( productIn.productId == nil || [productIn.productId isEqualToString:@""] ) productIn.productId = @"0";
    prod.productId = productIn.productId;
    
    if ( productIn.status == nil || [productIn.status isEqualToString:@""] ) productIn.status = @"n/a";
    prod.status = productIn.status;
    
    
    
    
    [self.allProducts addObject:prod];
}


-(void) processProducts
{
    // NSLog(@"getRetrieverQueryDone called");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WebConnectionComplete" object:nil];
    
    WebConnection * webConnection = [WebConnection sharedWebConnection];
    
    //DebugLog(@"Returned Data Length = %lu",[webConnection.webData length]);
    
    if ( [webConnection.webData length] == 0 ) {
        DebugLog(@"No Product Data Found");
        return;
    }
    // DebugLog(@"Process Products calling process json");

    [self processJSONString:webConnection.webData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductsComplete" object:nil userInfo:nil];


}
-(void)processJSONString:(NSMutableData * )jsonStringIn
{
    NSError *error;
    NSMutableDictionary *productList = [NSJSONSerialization
                                        JSONObjectWithData:jsonStringIn
                                        options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                        error:&error];
    
    DebugLog(@"Parsed the JSON data");
    
    if (error) {
        DebugLog(@"Error %@",[error localizedDescription]);
        
    } else {
        
        
        NSArray *products = productList[@"products"];
        Product * product = [[Product alloc ] init ];
        for ( NSDictionary *theProduct in products) {
            
            product.name = theProduct[@"productName"];
            product.costStr = theProduct[@"costPrice"];
            product.externalUrl = theProduct[@"externalUrl"];
            
            product.parentCategoryId = theProduct[@"parentCategoryId"];
            product.categoryId = theProduct[@"categoryId"];
            product.listPriceStr = theProduct[@"listPrice"];
            product.minPriceStr = theProduct[@"minPrice"];
            product.productId = theProduct[@"productId"];
            product.status = theProduct[@"productStatus"];
            product.warrantyPeriodMonths = theProduct[@"warrantyPeriodMonths"];
            
            [self createProduct:product];
            
        }
        
        
        
    }
    

    
}

-(void)addProductToCart:(Product *)productIn
{
    
    for ( Product * prod in allProducts ) {
        if ( [prod.productId isEqualToString:productIn.productId] ) {
            prod.inCart = TRUE;
            break;
        }
    }
    return;
    
    
}
-(void)removeProductFromCart:(Product *)productIn
{
    
    for ( Product * prod in allProducts ) {
        if ( [prod.productId isEqualToString:productIn.productId] ) {
            prod.inCart = FALSE;
            break;
        }
    }
    return;
    
    
}

-(void)clearCart
{
    
    for ( Product * prod in allProducts ) {
        prod.inCart = FALSE;
    }
    return;
    
    
}

-(Boolean)isProductInCart:(Product *)productIn
{
    
    for ( Product * prod in allProducts ) {
        if ( [prod.productId isEqualToString:productIn.productId] ) {
            if ( prod.inCart) {
                return TRUE;
            } else {
                return FALSE;
            }
        }
    }
    return FALSE;
}

-(int)productsInCart
{
    int cnt = 0;
    for ( Product * prod in allProducts ) {
        if ( prod.inCart) {
            cnt++;
        }
    }
    return cnt;
    
}


@end
