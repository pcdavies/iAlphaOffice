//
//  ViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "ViewController.h"
#import "WebConnection.h"
#import "DebugLogger.h"
#import "Products.h"
#import "Product.h"
#import "Cat.h"
#import "Categories.h"
#import "RESTManager.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize WebText;
@synthesize restMgr;

            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processData)
                                                 name:@"AllProductInfoComplete" object:nil];
    
    self.restMgr = [[RESTManager alloc] init];
    [restMgr getAllProductInfo];
     */
    [self processData];
    

}


-(void) processData
{
    /*
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllProductInfoComplete" object:nil];
     */
    
    NSString *tmpString = @"";
    
    
    for ( Product *prod in [[Products sharedProducts] allProducts]) {
        tmpString =[NSString
                       stringWithFormat:@"%@\n%@\n  id=%@\n  categoryId=%@\n  parentId=%@\n  cost=%@\n  status=%@\n  %@\n  parents(",
                       tmpString,
                       prod.name,prod.productId,prod.categoryId,prod.parentCategoryId,
                       prod.costStr,prod.status,prod.externalUrl];
        
        for ( NSString *str in prod.allParentCategoryIds ) {
            tmpString = [NSString stringWithFormat:@"%@ %@",tmpString,str];
        }
        
        
        tmpString =[NSString stringWithFormat:@"%@)\n",tmpString];
            
    }
    

    for ( Cat *cat in [[Categories sharedCategories] allCategories]) {
        tmpString =[NSString
                    stringWithFormat:@"%@\n%@\n  id=%@\n  prerentId=%@\n  level=%d\n ",
                    tmpString,
                    cat.name, cat.categoryId, cat.parentCategoryId, cat.categoryLevel ];

        
        
    }

    
    
    WebText.text = tmpString;
        
    // [self viewDidAppear:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
