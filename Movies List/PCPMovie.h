//
//  PCPMovie.h
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCPMovie : NSObject

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) int yearReleased;
@property (copy, nonatomic) NSString *slug;
@property (assign, nonatomic) float rating;
@property (copy, nonatomic) NSString *overview;

- (id)initWithTitle:(NSString *)title yearReleased:(int)yearReleased slug:(NSString *)slug;

@end
