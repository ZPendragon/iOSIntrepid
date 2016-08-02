//
//  ViewController.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SASearchViewController.h"

static NSString * const cellIdentifier = @"searchResultCell";

@interface SASearchViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation SASearchViewController

- (void) viewDidLoad {
    [super viewDidLoad];
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
    }
    return YES;
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *searchCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    searchCell.textLabel.text = @"Zedd";
    return searchCell;
}

@end
