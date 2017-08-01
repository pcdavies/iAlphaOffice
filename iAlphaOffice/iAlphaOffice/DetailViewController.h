//
//  DetailViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/21/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@interface DetailViewController : UIViewController{
    
    Product * product;
    
}

@property (nonatomic, retain) Product * product;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;
@property (weak, nonatomic) IBOutlet UIImageView *cartImage;


- (IBAction)addToCart:(UIButton *)sender;

@end
