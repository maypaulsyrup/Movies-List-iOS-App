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
    
    self.bacdropView.image = [UIImage imageNamed:@"fight-club-1999-backdrop.jpg"];
    
    self.coverView.image = [UIImage imageNamed:@"fight-club-1999-cover.jpg"];
    self.coverView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.coverView.layer.borderWidth = 2.0f;
    
    self.overviewLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla felis ex, commodo vitae tellus at, semper elementum lectus. Sed eget felis tortor. Suspendisse at varius sem. Aliquam in felis hendrerit, viverra ex sit amet, finibus ex. Nullam gravida eleifend eros, a malesuada eros venenatis nec. Aliquam eget ultrices metus, a pulvinar odio. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In malesuada mauris non scelerisque tincidunt. Maecenas vehicula vulputate pulvinar. In suscipit, dui ac sodales vulputate, ligula elit porta mauris, id scelerisque nibh massa ut est. Nam congue a ante id tempus. Curabitur et cursus nibh, in placerat massa. Etiam tempor ipsum vel sagittis faucibus. Donec laoreet volutpat metus eget pellentesque. Praesent sed tellus erat. Nulla vulputate convallis est vel pretium. Integer consectetur vel mauris ac aliquet. Proin quis nisl ut nibh varius scelerisque. Nulla convallis leo eget dolor aliquam, a lacinia metus facilisis. In fermentum dapibus ex nec hendrerit. Nullam elementum mollis nulla, at rhoncus dolor tincidunt et. Etiam quis ex interdum lacus pretium mollis mollis ut lectus. Suspendisse potenti. In quam augue, tempus ac nibh ac, euismod viverra nulla. Donec nec fringilla lorem, id sagittis lorem. Sed hendrerit orci non risus efficitur, quis scelerisque nunc mattis. Nunc ultricies ante id lectus scelerisque, quis aliquam felis fermentum. Duis et massa magna. Maecenas euismod tincidunt felis a feugiat. Nullam egestas leo eget nisl ullamcorper gravida. Nulla in massa finibus velit ullamcorper volutpat. Praesent blandit auctor diam eget tristique. Proin rutrum metus et condimentum fermentum. Sed lacinia odio in tortor sollicitudin hendrerit.";
}

@end
