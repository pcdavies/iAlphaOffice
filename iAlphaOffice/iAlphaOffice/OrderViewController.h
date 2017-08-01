//
//  OrderViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 10/1/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *CustomerName;
@property (weak, nonatomic) IBOutlet UITextField *Street;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextField *State;
@property (weak, nonatomic) IBOutlet UITextField *Zip;

@property (weak, nonatomic) IBOutlet UILabel *totalCost;

- (IBAction)placeOrder:(UIButton *)sender;

@end
