//
//  SAArtistViewController.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 8/3/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAArtist.h"

@interface SAArtistViewController : UIViewController

@property (nonatomic) SAArtist *detailArtist;

- (void)configureVC;
- (void)configureViews;
- (void)configureOutlets;
- (UIImage *)loadImage:(NSString *)url;

@end
