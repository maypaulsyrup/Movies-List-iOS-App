//
//  PCPMovieDetailViewController.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMovieDetailViewController.h"

#import "PCPConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface PCPMovieDetailViewController ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *coverViewWidthConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *overlayView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *overlayViewHeightConstraint;

@end

@implementation PCPMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.movie) {
        self.bacdropView.hidden = NO;
        [self.bacdropView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:PCPMovieBackdropURL, self.movie.slug]] placeholderImage:[UIImage imageNamed:@"backdrop-placeholder"]];
        
        self.coverView.hidden = NO;
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:PCPMovieCoverURL, self.movie.slug]]];
        self.coverView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.coverView.layer.borderWidth = 2.0f;
        
        self.overlayView.hidden = NO;
        
        self.titleLabel.hidden = NO;
        self.titleLabel.text = self.movie.title;
        self.yearLabel.hidden = NO;
        self.yearLabel.text = [NSString stringWithFormat:@"%d", self.movie.yearReleased];
        self.ratingLabel.hidden = NO;
        self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %1.1f", self.movie.rating];
        
        self.overviewLabel.text = self.movie.overview;
    } else {
        self.bacdropView.hidden = YES;
        self.coverView.hidden = YES;
        self.overlayView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.yearLabel.hidden = YES;
        self.ratingLabel.hidden = YES;
        self.overviewLabel.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        self.yearLabel.font = [UIFont systemFontOfSize:20.0f];
        self.ratingLabel.font = [UIFont systemFontOfSize:20.0f];
        self.coverViewWidthConstraint.constant = 180.0f;
        self.overlayViewHeightConstraint.constant = 150.0f;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification object:nil];
}

#pragma mark - Orientation change notification

- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown: {
            self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            self.yearLabel.font = [UIFont systemFontOfSize:15.0f];
            self.ratingLabel.font = [UIFont systemFontOfSize:15.0f];
            self.coverViewWidthConstraint.constant = 110.0f;
            self.overlayViewHeightConstraint.constant = 80.0f;
            break;
        }
            
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight: {
            self.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
            self.yearLabel.font = [UIFont systemFontOfSize:20.0f];
            self.ratingLabel.font = [UIFont systemFontOfSize:20.0f];
            self.coverViewWidthConstraint.constant = 180.0f;
            self.overlayViewHeightConstraint.constant = 150.0f;
            break;
        }
            
        case UIInterfaceOrientationUnknown:
        default:
            break;
    }
}

@end
