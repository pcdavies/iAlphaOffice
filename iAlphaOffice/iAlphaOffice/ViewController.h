//
//  ViewController.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RESTManager;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *WebText;
@property (nonatomic, retain) RESTManager * restMgr;
-(void) processData;

@end

