//
//  ViewController.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 7/29/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SASearchViewController.h"
#import "SAArtistViewController.h"

static NSString * const cellIdentifier = @"searchResultCell";
static SARequestManager *requestManager = nil;

@interface SASearchViewController () {
    NSArray *artists;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation SASearchViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    requestManager = [SARequestManager sharedInstance];
    [self configureVC];
}

// MARK: - Setup

- (void)configureVC {
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
        [requestManager getItemsWithQuery:searchQuery completion:^(SAResponse *response) {
            if (response.response == Failure) {
                NSLog(@"Error fetching artists");
            } else {
                NSLog(@"Success!!!");
                artists = response.items;
                [self.tableView reloadData];
            }
        }];
    }
    return YES;
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *searchCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    SAArtist *currentArtist = [[SAArtist alloc] init];
    currentArtist = artists[indexPath.row];
    searchCell.textLabel.text = currentArtist.name;
    return searchCell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SAArtistViewController *destinationController = segue.destinationViewController;
        SAArtist *currentArtist = artists[indexPath.row];
        NSLog(@"%@",currentArtist.name);
        NSLog(@"%@",currentArtist.image);
        NSLog(@"%@",currentArtist.artistDescription);
        destinationController.detailArtist = currentArtist;
        destinationController.navigationItem.title = currentArtist.name;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Search"
                                       style: UIBarButtonItemStylePlain
                                       target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
    }
}

@end
