//
//  CategoryProductViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/19/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "CategoryProductViewController.h"
#import "CategoryProductCollectionViewCell.h"
#import "Categories.h"
#import "Cat.h"
#import "Products.h"
#import "Product.h"
#import "DetailViewController.h"
#import "CartTableViewController.h"

@interface CategoryProductViewController () 

@end

@implementation CategoryProductViewController

@synthesize currentCategory;
@synthesize categories;
@synthesize products;


static NSString * const reuseIdentifier = @"Cell";

-(id) init
{
    if ( self = [super init] ) {
        
    }
    
    self.currentCategory = nil;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.categories = [[Categories sharedCategories] getCategories:currentCategory];
    self.products = [[Products sharedProducts] getProducts:currentCategory];
    

    if ( currentCategory == nil ) {
        self.categoryTitle.text = @"Category Filters";
        self.productTitle.text = @"Browse all Products";
        self.navigationItem.title = @"All Products";


    } else {
        self.categoryTitle.text = [NSString stringWithFormat:@"%@ Filters",currentCategory.name];
        self.productTitle.text = [NSString stringWithFormat:@"Browse %@ Products",currentCategory.name];
        self.navigationItem.title = currentCategory.name;

 
    }
    

    
    if ( [categories count] <=0 ) {
        _categoryCollectionView.hidden = YES;
        self.categoryTitle.hidden = YES;
        
        CGRect frame = self.productTitle.frame;
        
        frame.origin.y = 150;
        self.productTitle.frame = frame;
        
        CGRect frame2 = _productCollectionView.frame;
        frame2.origin.y = 168;
        _productCollectionView.frame = frame2;
    
    } else {
        _categoryCollectionView.delegate = self;
        _categoryCollectionView.dataSource = self;
    }
    
    _productCollectionView.delegate = self;
    _productCollectionView.dataSource = self;
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    // PAT CHANGE!!!!
    [super viewDidAppear:animated];
    //[super viewWillAppear:animated];
    
    if ([[Products sharedProducts] productsInCart] == 0 ) {
        self.productsInCart.hidden = YES;
    } else {
        NSString * numberName;
        if ( [[Products sharedProducts] productsInCart] > 14 ) {
            numberName = @"@blank.png";
        } else {
            numberName = [NSString stringWithFormat:@"%d.png",[[Products sharedProducts] productsInCart]];
            
        }
        [self.productsInCart setImage:[UIImage imageNamed:numberName]];
        self.productsInCart.hidden = NO;
    }
    // Need this in case the inCart indicator needs to be displayed. 
    [self.productCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)viewCart:(UIButton *)sender
{
    UIStoryboard *storyboard = self.storyboard;
    
    CartTableViewController *ctvc = [storyboard instantiateViewControllerWithIdentifier:@"CartTableViewController"];
    
    [self.navigationController pushViewController:ctvc animated:YES];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( collectionView.tag == 1 ) {

        return (NSInteger)[self.categories count];
    } else {
        return (NSInteger)[self.products count];
    }
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Configure the cell
    
    
    static NSString *CellIdentifier;
    
    CategoryProductCollectionViewCell *myCell;


    if ( collectionView.tag == 1 ) {
        // return cell;
        CellIdentifier = @"CategoryCell";
        
        int cnt = 0;
        for ( Cat * cat in self.categories) {
            if ( cnt == indexPath.item) {
                myCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

                [[myCell title] setText:cat.name];
                
                [[myCell image] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",cat.categoryId]]];
                
                
               
                myCell.category = cat;
                
                return myCell;
            }
            cnt++;
            
        }
    } else {
        CellIdentifier = @"ProductCell";
        int cnt = 0;
        
        for ( Product * prod in self.products) {
            if ( cnt  == indexPath.item) {
                myCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
                
                [[myCell title] setText:prod.name];
                [[myCell image] setImage:[UIImage imageNamed:prod.externalUrl]];
                
                if ( prod.inCart ) {
                    myCell.inCartIndicator.hidden = FALSE;
                } else {
                    myCell.inCartIndicator.hidden = TRUE;

                }
                myCell.product = prod;
                
                return myCell;

            }
            cnt++;
        }

    }
    
    
    
    return myCell;
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CategoryProductCollectionViewCell *cell = (CategoryProductCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    if ( collectionView.tag == 1 ) {
        
        UIStoryboard *storyboard = self.storyboard;

        CategoryProductViewController *cpvc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryProductViewController"];
        
        
        cpvc.currentCategory = cell.category;
        
        [self.navigationController pushViewController:cpvc animated:YES];
        
        

    } else {
        
        UIStoryboard *storyboard = self.storyboard;
        
        DetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        
        
        dvc.product = cell.product;
        
        [self.navigationController pushViewController:dvc animated:YES];
        

    }
    
    /*
    if (shareEnabled) {
        // Determine the selected items by using the indexPath
        NSString *selectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        // Add the selected item into the array
        [selectedRecipes addObject:selectedRecipe];
    }
     */
}



#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
