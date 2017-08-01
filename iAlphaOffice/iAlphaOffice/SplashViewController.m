//
//  SplashViewController.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/17/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import "SplashViewController.h"
#import "RESTManager.h"
#import "CartTableViewController.h"
#import "Products.h"

@interface SplashViewController ()

@end


@implementation SplashViewController

@synthesize restMgr;

// -- UIAlertView *alert;
UIAlertAction *alert;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Menu";
    
    
    //Step 1: Create a UIAlertController
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"MyTitle"
                                                                               message: @"MyMessage"
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    alert = [UIAlertAction
                         actionWithTitle:@"Retrieving Data...Click to dismiss"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: alert];
    
    //Step 4: Present the alert to the user
    [self presentViewController:myAlertController animated:YES completion:nil];
    

    // -- alert = [[UIAlertView alloc] initWithTitle:@"Retrieving Data..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    // -- UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // -- indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);

    
    // -- [alert show];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processData)
                                                 name:@"AllProductInfoComplete" object:nil];
        
    self.restMgr = [[RESTManager alloc] init];
    [restMgr getAllProductInfo];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    // PAT CHANGED !!!!
    [super viewDidAppear:animated];
    
    NSString *ipPort = [[NSUserDefaults standardUserDefaults] stringForKey:@"IPAddressPortKey"];
    
    [self.ipAddress setText:ipPort];


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
}

-(void) processData
{
    // -- [alert dismissWithClickedButtonIndex:0 animated:YES];
    
        
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllProductInfoComplete" object:nil];
    
    // Load next view
    
}

- (IBAction)viewCart:(UIButton *)sender
{
    UIStoryboard *storyboard = self.storyboard;
    
    CartTableViewController *ctvc = [storyboard instantiateViewControllerWithIdentifier:@"CartTableViewController"];
    
    [self.navigationController pushViewController:ctvc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
