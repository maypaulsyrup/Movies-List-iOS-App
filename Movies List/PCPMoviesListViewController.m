//
//  PCPMoviesListViewController.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMoviesListViewController.h"

#import "PCPConstants.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PCPMovie.h"
#import "PCPMovieCell.h"
#import "PCPMovieDetailViewController.h"

@interface PCPMoviesListViewController () <UISplitViewControllerDelegate>

@property (assign, getter=isLoading) BOOL loading;
@property (assign, nonatomic) int pageNumber;
@property (assign, nonatomic) BOOL hasReachedLastPage;

@end

@implementation PCPMoviesListViewController

static int const PCPMoviesListFirstPage = 1;

- (void)fetchMoviesFromServer {
    self.loading = YES;
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [requestManager GET:[NSString stringWithFormat:PCPMoviesListURL, self.pageNumber] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self pageNumber] == PCPMoviesListFirstPage) {
            [self.movies removeAllObjects];
        }
        
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            for (NSDictionary *movieDictionary in responseObject[@"data"][@"movies"]) {
                PCPMovie *movie = [[PCPMovie alloc] initWithTitle:movieDictionary[@"title"] yearReleased:[movieDictionary[@"year"] intValue] slug:movieDictionary[@"slug"]];
                movie.rating = [movieDictionary[@"rating"] floatValue];
                movie.overview = movieDictionary[@"overview"];
                
                [self.movies addObject:movie];
            }
            
            [self.refreshControl endRefreshing];
            self.loading = NO;
            
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *errorInfo = [error userInfo];
        NSLog(@"Error -- %@", errorInfo[@"NSLocalizedDescription"]);
        NSLog(@"Error Code: %d", [error code]);
        
        if ([error code] == -1009 || [error code] == -1003) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:errorInfo[@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else if ([error code] == -1011) {
            self.hasReachedLastPage = YES;
        }
        
        [self.refreshControl endRefreshing];
        self.loading = NO;
        [self.tableView reloadData];
    }];
}

- (void)reloadMovies {
    if ([self isLoading]) {
        return;
    }
    
    self.pageNumber = PCPMoviesListFirstPage;
    [self fetchMoviesFromServer];
}

- (void)loadMoreMovies {
    if ([self isLoading]) {
        return;
    }
    
    self.pageNumber++;
    [self fetchMoviesFromServer];
}

#pragma mark - Appearance customization

- (void)configureAppearance {
    UILabel *loadingMessage = [[UILabel alloc] init];
    loadingMessage.text = @"Loading movies... If this takes too long, pull down to refresh.";
    loadingMessage.numberOfLines = 0;
    loadingMessage.textAlignment = NSTextAlignmentCenter;
    loadingMessage.font = [UIFont italicSystemFontOfSize:20.0f];
    loadingMessage.center = self.view.center;
    [loadingMessage sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.frame) - 30, CGRectGetHeight(self.view.frame))];
    
    self.tableView.backgroundView = loadingMessage;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.splitViewController.delegate = self;
    
    self.movies = [NSMutableArray array];
    
    self.pageNumber = PCPMoviesListFirstPage;
    [self fetchMoviesFromServer];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadMovies) forControlEvents:UIControlEventValueChanged];
    
    [self configureAppearance];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.movies count] == 0 || [self isLoading] || [self hasReachedLastPage]) {
        return [self.movies count];
    } else {
        return [self.movies count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.movies count]) {
        UITableViewCell *loadMoreCell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell" forIndexPath:indexPath];
        
        // Configure the cell...
        loadMoreCell.textLabel.hidden = NO;
        
        return loadMoreCell;
    } else {
        PCPMovie *movie = self.movies[indexPath.row];
        
        PCPMovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
        
        // Configure the cell...
        [movieCell.backdropView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:PCPMovieBackdropURL, [movie slug]]] placeholderImage:[UIImage imageNamed:@"backdrop-placeholder"]];
        
        movieCell.titleLabel.text = [movie title];
        movieCell.yearLabel.text = [NSString stringWithFormat:@"%d", [movie yearReleased]];
        
        return movieCell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.movies count]) {
        return 44.0f;
    } else {
        return 196.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.movies count]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *loadMoreCell = [tableView cellForRowAtIndexPath:indexPath];
        
        loadMoreCell.textLabel.hidden = YES;
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.center = [loadMoreCell.contentView center];
        [loadMoreCell addSubview:loadingView];
        [loadingView startAnimating];
        
        [self loadMoreMovies];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        PCPMovie *movie = self.movies[indexPath.row];
        
        PCPMovieDetailViewController *movieDetailViewController = nil;
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            movieDetailViewController = (PCPMovieDetailViewController *)[segue.destinationViewController topViewController];
        } else {
            movieDetailViewController = [segue destinationViewController];
        }
        
        movieDetailViewController.movie = movie;
    }
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[PCPMovieDetailViewController class]] && ([(PCPMovieDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] movie] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}

@end
