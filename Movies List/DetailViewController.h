//
//  DetailViewController.h
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

