//
//  OrderViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 10/1/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "OrderViewController.h"
#import "Product.h"
#import "Products.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    double total = 0.0;
    
    
    
    for ( Product * prod in [[Products sharedProducts] getProductsInCart]) {
        total = total + [prod.costStr doubleValue];
    }

    self.totalCost.text = [NSString stringWithFormat:@" $%.2f",total];
    
    self.Zip.delegate = self;
    self.CustomerName.delegate = self;
    self.Street.delegate = self;
    self.City.delegate = self;
    self.State.delegate = self;
    self.Zip.delegate = self;
    
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)placeOrder:(UIButton *)sender
{

    [[Products sharedProducts] clearCart];
    
    UIAlertView* alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Order Successful" message:@"Thanks for your purchase!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
    // [self.navigationController  popToRootViewControllerAnimated: YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.navigationController  popToRootViewControllerAnimated: YES];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
