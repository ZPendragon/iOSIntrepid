//
//  SAArtistViewController.m
//  Spotify-ObjC
//
//  Created by Kevin Zeckser on 8/3/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

#import "SAArtistViewController.h"

@interface SAArtistViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artistForegroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *artistBackgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation SAArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureVC {
    [self configureViews];
    [self configureOutlets];
}

- (void)configureViews {
    UIColor *backgroundColor = [UIColor blackColor];
    UIColor *textColor = [UIColor whiteColor];
    self.view.backgroundColor = backgroundColor;
    self.navigationController.navigationBar.barTintColor = backgroundColor;
    self.navigationController.navigationBar.tintColor = textColor;
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: textColor}];
    
    self.artistForegroundImage.layer.cornerRadius = self.artistForegroundImage.bounds.size.width / 2;
    self.artistForegroundImage.clipsToBounds = true;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.artistBackgroundImage.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.artistBackgroundImage addSubview: blurEffectView];
    
    self.descriptionLabel.textColor = textColor;
}

- (void)configureOutlets {
    if (self.detailArtist) {
        UIImage *artistImage = [self loadImage:self.detailArtist.image];
        self.artistForegroundImage.image = artistImage;
        self.artistBackgroundImage.image = artistImage;
        self.descriptionLabel.text = self.detailArtist.artistDescription;
    }
}

- (UIImage *)loadImage:(NSString *)url {
    if ([url isEqualToString:@""]) {
        return [UIImage imageNamed:@"default_artist_image"];
    } else {
    NSURL *imgURL = [NSURL URLWithString: url];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    return [UIImage imageWithData:imgData];
    }
}

@end
