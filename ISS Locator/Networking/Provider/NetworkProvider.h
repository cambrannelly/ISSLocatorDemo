//
//  NetworkProvider.h
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkProvider : NSObject
- (void)get:(NSString *)url completionHandler:(void (NS_SWIFT_SENDABLE ^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
