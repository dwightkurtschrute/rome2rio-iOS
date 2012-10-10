//
//  R2RConnection.m
//  HttpRequest
//
//  Created by Ash Verdoorn on 30/08/12.
//  Copyright (c) 2012 Ash Verdoorn. All rights reserved.
//

#import "R2RConnection.h"
#import "R2RPlace.h"

@interface R2RConnection()

@property (strong, nonatomic) NSURLConnection *connection;

@end    

@implementation R2RConnection

@synthesize responseData, connection, delegate, connectionString;

-(id) initWithConnectionUrl:(NSURL *)connectionUrl delegate:(id<R2RConnectionDelegate>)r2rConnectionDelegate
{
    self = [super init];
    
    if (self != nil)
    {
        
        self.delegate = r2rConnectionDelegate;
        
        self.responseData = [NSMutableData data];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:connectionUrl];
        
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

        self.connectionString = [NSString stringWithFormat:@"%@", connectionUrl];
//        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//        [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//        [self.connection start];
//        NSLog(@"%@", [NSRunLoop currentRunLoop]);
        
    }
    
    return self;
    
}

//-(void) sendAsynchronousRequest
//{
//    NSURLRequest *request = [NSURLRequest requestWithURL:self.connectionUrl];
//    
//    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}	

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error localizedDescription]);
    
    [[self delegate] R2RConnectionError:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    
//    NSError *error = nil;
//    
//    NSDictionary *rData = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
//    
//    NSLog(@"%@", error);
//    // show all values/////////////////////////////
//    for(id key in rData) {
//        
//        id value = [rData objectForKey:key];
//        
//        NSString *keyAsString = (NSString *)key;
//        NSString *valueAsString = (NSString *)value;
//        
//        NSLog(@"key: %@", keyAsString);
//        NSLog(@"value: %@", valueAsString);
//    }/////////////////////////////////////////////
    //Is anyone listening
    //if([delegate respondsToSelector:@selector(connectionDidFinishLoading:)])
    //{
    
        [[self delegate] R2RConnectionProcessData:self];
    
    //}
}


@end
