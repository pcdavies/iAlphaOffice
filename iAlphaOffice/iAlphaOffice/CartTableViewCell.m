//
//  CartTableViewCell.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/25/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "CartTableViewCell.h"
#import "Product.h"
#import "Products.h"

@implementation CartTableViewCell
@synthesize product;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
