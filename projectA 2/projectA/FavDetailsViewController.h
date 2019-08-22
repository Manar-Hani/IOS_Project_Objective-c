//
//  FavDetailsViewController.h
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import <UIKit/UIKit.h>
#import "Movies.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface FavDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextView *overview;

@property (weak, nonatomic) IBOutlet UILabel *rating;

@property Movies *movie;

@property NSMutableArray *favarray;

@end


