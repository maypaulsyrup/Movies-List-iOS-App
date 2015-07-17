//
//  PCPMovieDetailViewController.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMovieDetailViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation PCPMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bacdropView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-backdrop.jpg", self.movie.slug]];
    
    self.coverView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-cover.jpg", self.movie.slug]];
    self.coverView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.coverView.layer.borderWidth = 2.0f;
    
    self.titleLabel.text = self.movie.title;
    self.yearLabel.text = [NSString stringWithFormat:@"%d", self.movie.yearReleased];
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %1.1f", self.movie.rating];
    
    self.overviewLabel.text = self.movie.overview;
}

@end
