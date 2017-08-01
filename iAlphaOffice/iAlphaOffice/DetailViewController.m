//
//  DetailViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/21/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "DetailViewController.h"
#import "Product.h"
#import "Products.h"

@interface DetailViewController ()



@end

@implementation DetailViewController

@synthesize product;
@synthesize productImage;
@synthesize productName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productName.text = product.name;
    [productImage setImage:[UIImage imageNamed:product.externalUrl]];
    _cost.text = [NSString stringWithFormat:@"Cost: $%@",product.costStr];
    
    // NSLog(@"Product Id = %@, inCart = %d",self.product.productId,product.inCart);
    
    NSString * cartImageName;

    if ( self.product.inCart ) {
        // NSLog(@"Setting title");
        [_addToCart setTitle:@"Product in Cart..." forState:UIControlStateNormal];
        cartImageName = @"cartFull.png";
    } else {
       cartImageName = @"cartEmpty.png";
    }
    [self.cartImage setImage:[UIImage imageNamed:cartImageName]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCart:(UIButton *)sender
{
    if ( [[Products sharedProducts] isProductInCart:self.product] ) {
        [[Products sharedProducts] removeProductFromCart:self.product];
        [_addToCart setTitle:@"Add to Cart" forState:UIControlStateNormal];
        [self.cartImage setImage:[UIImage imageNamed:@"cartEmpty.png"]];
    } else {
        
        [[Products sharedProducts] addProductToCart:self.product];
        [_addToCart setTitle:@"Remove from Cart" forState:UIControlStateNormal];
        [self.cartImage setImage:[UIImage imageNamed:@"cartFull.png"]];
       
    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
