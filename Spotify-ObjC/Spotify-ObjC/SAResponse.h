//
//  SAResponse.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SAArtist.h"

typedef NS_ENUM(NSInteger, NetworkResponse) {
    Success = 0,
    Failure
};

@interface SAResponse : NSObject

@property (nonatomic) NetworkResponse *response;
@property (nonatomic, strong) NSMutableArray *artists;
@property (nonatomic) NSError *error;

@end
