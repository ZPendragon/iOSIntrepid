//
//  SARequestManager.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SARequestManager.h"

@interface SARequestManager ()

@end

@implementation SARequestManager

static NSURLSession *session;
static SARequestManager *sharedInstance = nil;

- (void) singletonInit {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration: sessionConfig];
}

+ (SARequestManager *) sharedInstance {
    static dispatch_once_t dispatchOncePredicate = 0;
    dispatch_once(&dispatchOncePredicate, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance singletonInit];
    });
    return sharedInstance;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [SARequestManager sharedInstance];
}

- (void) getArtistsWithQuery:(NSString *)query completion:(Completion)completion {
    NSMutableString *path = [NSMutableString stringWithFormat: @"https://api.spotify.com/v1/search?q=%@", query];
    NSString *parameters = @"&type=track,artist&market=US";
    [path appendString: parameters];
    
    NSURL *url = [NSURL URLWithString: path];
    NSURLSessionDataTask *task = [session dataTaskWithURL: url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            SAResponse *result;
                                            NSLog(@"Getting Data");
                                            if (!data) {
                                                *(result.response) = Failure;
                                                NSLog(@"Error: %@", [error localizedDescription]);
                                            } else {
                                                NSLog(@"Returned Response: %@ \n", data);
                                                *(result.response) = Success;
                                                // TODO:
                                                /*
                                                 - parse data object with NSJSON
                                                 - Build [SAArtist] from JSON object.
                                                 - pass [SAArtist] to SAResponse.artists
                                                 */
                                            }
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                completion(result);
                                            });
                                        }];
}


@end
