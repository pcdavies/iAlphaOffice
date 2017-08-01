//
//  CartTableViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/24/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@interface CartTableViewController : UITableViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *PlaceOrderButton;
- (IBAction)purgeCart:(id)sender;
@end
