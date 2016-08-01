//
//  ViewController.h
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAResponse.h"

@interface SASearchViewController : UITableViewController <UITextFieldDelegate>

- (void) updateFilteredArtistsWithResponse:(SAResponse *)result;
- (void) setupVC;

@end
