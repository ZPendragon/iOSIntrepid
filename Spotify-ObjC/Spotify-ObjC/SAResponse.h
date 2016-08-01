//
//  SAResponse.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SAArtist.h"

typedef NS_ENUM(NSInteger, NetworkResponse) {
    Success,
    Failure
};

@interface SAResponse : NSObject

@property (nonatomic) NetworkResponse *response;
@property (nonatomic) NSArray *artists;
@property (nonatomic) NSError *error;

@end
