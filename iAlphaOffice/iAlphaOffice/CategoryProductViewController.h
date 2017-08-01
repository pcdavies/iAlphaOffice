//
//  CategoryProductViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/19/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cat;

@interface CategoryProductViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {

    Cat * currentCategory;
    NSMutableArray * categories;
    NSMutableArray * products;


}

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (nonatomic, retain) Cat * currentCategory;
@property (nonatomic, retain) NSMutableArray * categories;
@property (nonatomic, retain) NSMutableArray * products;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UIImageView *productsInCart;

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *productCollectionView;

- (IBAction)viewCart:(UIButton *)sender;




@end
