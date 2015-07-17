//
//  PCPMovieCell.h
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCPMovieCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *backdropView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;

@end
