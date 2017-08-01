//
//  WebConnection.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface WebConnection : NSObject

@property (nonatomic, assign) Boolean getProductRequest;
@property (nonatomic, retain) NSMutableData *webData;
@property (nonatomic, retain) NSURLConnection *_currentConnection;

+(WebConnection *)sharedWebConnection;
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


-(void)getData:(NSString *)str;
-(void)getFileData;


@end
