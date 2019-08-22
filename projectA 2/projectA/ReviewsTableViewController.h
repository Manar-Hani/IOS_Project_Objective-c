//
//  ReviewsTableViewController.h
//  projectA
//
//  Created by Lost Star on 4/15/19.
//

#import <UIKit/UIKit.h>
#import "Movies.h"
#import "Networking.h"
#import "DetailesViewController.h"


@interface ReviewsTableViewController : UITableViewController



@property Movies *movie ;
@property (nonatomic) NSMutableArray *reviews;

@end


