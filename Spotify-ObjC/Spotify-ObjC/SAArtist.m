//
//  SAArtist.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAArtist.h"

@implementation SAArtist

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _name = nil;
        _image = nil;
        _artistDescription = nil;
    }
    return self;
}

@end