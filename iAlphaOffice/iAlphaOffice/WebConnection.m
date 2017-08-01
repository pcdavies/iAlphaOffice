//
//  WebConnection.m
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//
#import "WebConnection.h"
#import "DebugLogger.h"

static WebConnection * shared = NULL;
NSURLRequest *theRequest;

@implementation WebConnection

@synthesize webData;
@synthesize _currentConnection;
@synthesize getProductRequest;


+(WebConnection *)sharedWebConnection
{
    @synchronized(self) {
        if ( !shared || shared == NULL ) {
            shared = [[WebConnection alloc] init];
            DebugLog(@"\n\n!!!!!!!!!!!!!allocated SSLConnection !!!!!!!!!!!!\n\n");
        }
    }
    return shared;
}



-(id) init
{
    
    return self;
    
}

-(void)getData:(NSString *)str
{
    
    webData = nil;
    
    NSString *prodUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"ProductURLKey"];

    if ( [str rangeOfString:prodUrl].location == NSNotFound) {
        self.getProductRequest = FALSE;
    } else {
        self.getProductRequest = TRUE;
    }

    
    BOOL offline = [[NSUserDefaults standardUserDefaults] boolForKey:@"OfflineKey"];

    if (offline) {
        
        
        // This is required, because you need the file read to be performed in another thread,
        // in the same way that the data is called for the REST APIs asynchronously
        [self performSelectorInBackground:@selector(getFileData) withObject:nil];
        
        return;
        
    }
    
    float timeout = 60.0;

    
    
    // Create the request.
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:str]
                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                            timeoutInterval:timeout];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        // receivedData = [[NSMutableData data] retain];
        
        
    } else {
        // Inform the user that the connection failed.
    }
}



-(void)getFileData
{
    
    DebugLog(@"Calling processJson from offline string");
    
    NSString *path;
    // NSString *catUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"CategoryURLKey"];
    
    if ( self.getProductRequest) {
        path = [[NSBundle mainBundle] pathForResource:@"productJson" ofType:@"txt"];
        NSLog(@"Getting product file");
        
        
    } else {
        path = [[NSBundle mainBundle] pathForResource:@"categoryJson" ofType:@"txt"];
        NSLog(@"Getting category file");
        
        
    }
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    
    NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    webData = [[NSMutableData alloc] init];
    [webData appendData:data];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WebConnectionComplete" object:nil userInfo:nil];

    
}


- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSLog(@"Ignoring SSL");
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        NSURLCredential *cred;
        cred = [NSURLCredential credentialForTrust:trust];
        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
        return;
    }
    
    // Provide your regular login credential if needed...
}
 

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    webData = [NSMutableData data];
    
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [webData appendData:data];
    
       
    //DebugLog(@"didReceiveData: \n%@",[[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
    
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    //[connection release];
    connection = nil;
    // receivedData is declared as a method instance elsewhere
    //[receivedData release];
    // webData = nil;
    
    // inform the user


    DebugLog(@"\n\n\n!!!!!!! Connection failed: Error - %@ %@\n\n\n",
             [error localizedDescription],
             [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WebConnectionComplete" object:nil userInfo:nil];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    DebugLog(@"Succeeded! Received %d bytes of data",(unsigned)[webData length]);
    
    // release the connection, and the data object
    connection = nil;
    // webData = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WebConnectionComplete" object:nil userInfo:nil];
    
    
}

/* 
 Added to try and overcome the cert issue

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)space {
    
    Boolean shouldAllowSelfSignedCert = YES;
    
    if([[space authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if(shouldAllowSelfSignedCert) {
            
            DebugLog(@"Received Self Signed Cert Sending YES");

            return YES; // Self-signed cert will be accepted
        } else {
            DebugLog(@"Received Self Signed Cert Sending NO");

            
            return NO;  // Self-signed cert will be rejected
        }
        // Note: it doesn't seem to matter what you return for a proper SSL cert
        //       only self-signed certs
    }
    // If no other authentication is required, return NO for everything else
    // Otherwise maybe YES for NSURLAuthenticationMethodDefault and etc.
    return NO;
}
 */


/*
 - (NSURLRequest *)connection: (NSURLConnection *)inConnection
 willSendRequest: (NSURLRequest *)inRequest
 redirectResponse: (NSURLResponse *)inRedirectResponse;
 {
 if (inRedirectResponse) {
 NSMutableURLRequest *r = [theRequest mutableCopy]; // original request
 [r setURL: [inRequest URL]];
 return r;
 } else {
 return inRequest;
 }
 }
 
 */


@end