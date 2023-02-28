//
//  NetworkProvider.m
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

#import "NetworkProvider.h"

@implementation NetworkProvider

- (void)get:(NSString *)url completionHandler:(void (NS_SWIFT_SENDABLE ^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString: url]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: completionHandler
     ] resume];
}
@end
