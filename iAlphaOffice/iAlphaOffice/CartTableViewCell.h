//
//  CartTableViewCell.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/25/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Product;
@interface CartTableViewCell : UITableViewCell
{
    Product * product;
}
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (nonatomic, retain) Product * product;


@end
