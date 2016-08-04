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
                                            SAResponse *result = [[SAResponse alloc] init];
                                            if (!data) {
                                                result.error = error;
                                            } else {
                                                NSError *jsonError = nil;
                                                NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData: data
                                                                                                           options: NSJSONReadingMutableContainers
                                                                                                             error: &jsonError];
                                                NSMutableArray *returnedArtists = [[NSMutableArray alloc] init];
                                                
                                                if ([jsonResult objectForKey:@"artists"]) {
                                                    NSDictionary *artistResponse = [jsonResult objectForKey:@"artists"];
                                                    NSArray *artists = [artistResponse objectForKey:@"items"];
                                                    for (NSDictionary *artistEntry in artists) {
                                                        NSArray *images = [artistEntry objectForKey:@"images"];
                                                        SAArtist *artist = [[SAArtist alloc] init];
                                                        artist.name = [artistEntry objectForKey:@"name"];
                                                        artist.image = [self fetchImageURL:images];
                                                        artist.artistDescription = @"This band is awesome!";
                                                        [returnedArtists addObject: artist];
                                                    }
                                                }
                                                [result setArtists:returnedArtists];
                                            }
                                            dispatch_sync(dispatch_get_main_queue(), ^{
                                                completion(result);
                                            });
                                        }];
    [task resume];
}

- (NSString *) fetchImageURL:(NSArray *)images {
    for (NSDictionary *image in images) {
        NSNumber *height = [image objectForKey:@"height"];
        NSNumber *width = [image objectForKey:@"width"];
        
        if (width == height) {
            NSString *url = [image objectForKey:@"url"];
            return url;
        }
    }
    return nil;
}

@end
