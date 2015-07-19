//
//  PCPMovie.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMovie.h"

@implementation PCPMovie

- (id)initWithTitle:(NSString *)title yearReleased:(int)yearReleased slug:(NSString *)slug {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.yearReleased = yearReleased;
        self.slug = slug;
    }
    
    return self;
}

@end
