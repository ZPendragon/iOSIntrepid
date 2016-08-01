//
//  SAArtist.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 8/1/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAArtist : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *artistDescription;

+ (NSArray *) configureWithJSON:(NSData *)responseData;
+ (NSString *) fetchImageURL:(NSArray *)images;

@end
