//
//  PCPMoviesListViewController.m
//  Movies List
//
//  Created by Paul Carlo Peralta on 7/17/15.
//  Copyright (c) 2015 Paul Carlo Peralta. All rights reserved.
//

#import "PCPMoviesListViewController.h"

#import "PCPMovie.h"
#import "PCPMovieCell.h"
#import "PCPMovieDetailViewController.h"

@interface PCPMoviesListViewController () <UISplitViewControllerDelegate>

@property (copy, nonatomic) NSArray *movies;

@end

@implementation PCPMoviesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.splitViewController.delegate = self;
    
    PCPMovie *movie1 = [[PCPMovie alloc] initWithTitle:@"The Shawshank Redemption" yearReleased:1994 andSlug:@"the-shawshank-redemption-1994"];
    movie1.rating = 9.2f;
    movie1.overview = @"Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.";
    
    PCPMovie *movie2 = [[PCPMovie alloc] initWithTitle:@"The Godfather" yearReleased:1972 andSlug:@"the-godfather-1972"];
    movie2.rating = 9.1f;
    movie2.overview = @"The story spans the years from 1945 to 1955 and chronicles the fictional Italian-American Corleone crime family. When organized crime family patriarch Vito Corleone barely survives an attempt on his life, his youngest son, Michael, steps in to take care of the would-be killers, launching a campaign of bloody revenge.";
    
    PCPMovie *movie3 = [[PCPMovie alloc] initWithTitle:@"The Godfather: Part II" yearReleased:1974 andSlug:@"the-godfather-part-ii-1974"];
    movie3.rating = 9.0f;
    movie3.overview = @"The continuing saga of the Corleone crime family tells the story of a young Vito Corleone growing up in Sicily and in 1910s New York; and follows Michael Corleone in the 1950s as he attempts to expand the family business into Las Vegas, Hollywood and Cuba";
    
    PCPMovie *movie4 = [[PCPMovie alloc] initWithTitle:@"The Dark Knight" yearReleased:2008 andSlug:@"the-dark-knight-2008"];
    movie4.rating = 8.9f;
    movie4.overview = @"Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.";
    
    PCPMovie *movie5 = [[PCPMovie alloc] initWithTitle:@"Fight Club" yearReleased:1999 andSlug:@"fight-club-1999"];
    movie5.rating = 8.9f;
    movie5.overview = @"A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.";
    
    self.movies = @[movie1, movie2, movie3, movie4, movie5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCPMovie *movie = self.movies[indexPath.row];
    
    PCPMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backdropView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-backdrop.jpg", movie.slug]];
    cell.titleLabel.text = movie.title;
    cell.yearLabel.text = [NSString stringWithFormat:@"%d", movie.yearReleased];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 196.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
            movieDetailViewController = segue.destinationViewController;
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
