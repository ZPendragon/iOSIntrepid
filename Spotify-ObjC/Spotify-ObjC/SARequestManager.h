//
//  SARequestManager.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAResponse.h"

typedef void (^Completion)(SAResponse *response);


@interface SARequestManager : NSObject

+ (SARequestManager *) sharedInstance;
+ (id) allocWithZone:(struct _NSZone *)zone;
- (void) singletonInit;
//- (void) getArtistsWithQuery:(NSString *)query completion:(Completion)completion;
- (void) getArtistsWithQuery:(NSString *)query completion:(SEL)updateArtistsWithResult;
- (NSString *) fetchImage:(NSArray *)images;

@end
