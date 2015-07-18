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
        self.titleLabel.hidden = YES;
        self.yearLabel.hidden = YES;
        self.ratingLabel.hidden = YES;
        self.overviewLabel.hidden = YES;
    }
}

@end
