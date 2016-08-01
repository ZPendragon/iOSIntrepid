//
//  ViewController.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SASearchViewController.h"

static NSString * const cellIdentifier = @"searchResultCell";
static SARequestManager *requestManager = nil;

@interface SASearchViewController () {
    NSArray *artists;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation SASearchViewController

- (void) updateFilteredArtistsWithResponse:(SAResponse *)result {
    if (*(result.response) == Failure) {
        NSLog(@"Error fetching artists");
    } else {
        NSLog(@"Success!!!");
        artists = result.artists;
        [self.tableView reloadData];
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    requestManager = [SARequestManager sharedInstance];
    [self setupVC];
}

// MARK: - Setup

- (void)setupVC {
    UIColor *backgroundColor = [UIColor blackColor];
    UIColor *placeholderTextColor = [UIColor whiteColor];
    self.view.backgroundColor = backgroundColor;
    self.textField.backgroundColor = backgroundColor;
    self.navigationController.navigationBar.barTintColor = backgroundColor;
    self.navigationController.navigationBar.backgroundColor = backgroundColor;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search Spotify" attributes:@{NSForegroundColorAttributeName: placeholderTextColor}];
}

//MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *searchQuery = self.textField.text;
    if ([searchQuery isEqualToString:@""]) {
        return YES;
    } else {
        // Run our query
        NSLog(@"Hello");
        NSLog(@"%p",requestManager);
        [requestManager getArtistsWithQuery:searchQuery completion: @selector(updateFilteredArtistsWithResponse:)];
    }
    return YES;
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *searchCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    SAArtist *currentArtist = artists[indexPath.row];
    searchCell.textLabel.text = currentArtist.name;
    return searchCell;
}

@end
