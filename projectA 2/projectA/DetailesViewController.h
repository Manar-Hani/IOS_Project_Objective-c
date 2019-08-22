//
//  DetailesViewController.h
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import <UIKit/UIKit.h>
#import "Movies.h"



@interface DetailesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *tit;
@property (weak, nonatomic) IBOutlet UITextView *overview;

@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *releasedate;
@property (weak, nonatomic) IBOutlet UIButton *btnfav;
@property (weak, nonatomic) IBOutlet UIButton *btnvideo;

- (IBAction)favBtn:(id)sender;
- (IBAction)videoBtn:(id)sender;
- (IBAction)reviewsBtn:(id)sender;

@property (nonatomic) Movies *movie ;
@property (nonatomic) NSString *key;
@property (nonatomic) NSMutableArray *reviews;



@end


