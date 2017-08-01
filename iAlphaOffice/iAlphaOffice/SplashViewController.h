//
//  SplashViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/17/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RESTManager;

@interface SplashViewController : UIViewController

@property (nonatomic, retain) RESTManager * restMgr;
@property (weak, nonatomic) IBOutlet UIImageView *productsInCart;
@property (weak, nonatomic) IBOutlet UILabel *ipAddress;


-(void) processData;
- (IBAction)viewCart:(UIButton *)sender;

@end
