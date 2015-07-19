//
//  PCPMovieCell.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMovieCell.h"

@implementation PCPMovieCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.backdropView.layer.opacity = 0.4f;
    } else {
        self.backdropView.layer.opacity = 1.0f;
    }
}

@end
