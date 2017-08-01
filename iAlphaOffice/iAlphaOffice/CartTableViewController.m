//
//  CartTableViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/24/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "CartTableViewController.h"
#import "Products.h"
#import "Product.h"
#import "CartTableViewCell.h"

@interface CartTableViewController ()

@end

@implementation CartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if ( [[[Products sharedProducts] getProductsInCart] count] == 0 ) {
        self.PlaceOrderButton.enabled = FALSE;
    } else {
        self.PlaceOrderButton.enabled = YES;
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)purgeCart:(id)sender;
{
    [[Products sharedProducts] clearCart];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return([[[Products sharedProducts] getProductsInCart] count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell"];
    
    
    int cnt = 0;
        
    for ( Product * prod in [[Products sharedProducts] getProductsInCart]) {
        if ( cnt == indexPath.row) {
            // cell = (CartTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            [cell.productName setText:prod.name];
            [cell.productImage setImage:[UIImage imageNamed:prod.externalUrl]];
            cell.product = prod;
            break;
        }
        cnt++;
    }
    
    return cell;
  
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        int cnt = 0;
        
        for ( Product * prod in [[Products sharedProducts] getProductsInCart]) {
            if ( cnt == indexPath.row) {
                [[Products sharedProducts] removeProductFromCart:prod];
                break;

            }
            cnt++;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        if ( [[[Products sharedProducts] getProductsInCart] count] == 0 ) {
            self.PlaceOrderButton.enabled = FALSE;
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
