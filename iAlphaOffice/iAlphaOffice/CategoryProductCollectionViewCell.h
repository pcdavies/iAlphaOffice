//
//  CategoryProductCollectionViewCell.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/19/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cat;
@class Product;

@interface CategoryProductCollectionViewCell : UICollectionViewCell

@property (weak) IBOutlet UIImageView *image;
@property (weak) IBOutlet UILabel *title;


@property (nonatomic, retain)  Cat * category;
@property (nonatomic, retain)  Product * product;
@property (weak, nonatomic) IBOutlet UIImageView *inCartIndicator;


@end
