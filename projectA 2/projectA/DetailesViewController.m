
//
//  DetailesViewController.m
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import "DetailesViewController.h"
#import "ReviewsTableViewController.h"
#import "Movies.h"
#import "Networking.h"
#import "ViewController1.h"
#import "DataBase.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <HCSStarRatingView.h>

@interface DetailesViewController (){
    DataBase *db;
    Boolean flag;
    Networking *net;
    NSString *s;
    float r;
    ReviewsTableViewController *rv;
}

@end

@implementation DetailesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // _movie = [Movies new];
     db=[DataBase sharedInstance];
    net=[Networking sharedInstance];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
  
    _tit.text=_movie.title;
     NSLog(@"title %@", [_movie title]);
    _overview.text=_movie.overview;
     NSLog(@"overview %@", [_movie overview]);
    _rate.text=[NSString stringWithFormat:@"%@",_movie.rating];
     NSLog(@"rating %@", [_movie rating]);
    _releasedate.text=_movie.release_date;
     NSLog(@"release %@", [_movie release_date]);
    
    r=[[_movie rating] floatValue];
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(220, 290, 130, 30)];
        starRatingView.maximumValue = 5;
        starRatingView.minimumValue = 0;
        starRatingView.backgroundColor=[UIColor whiteColor];
        starRatingView.value = r/2;
        starRatingView.tintColor = [UIColor yellowColor];
        starRatingView.accurateHalfStars = YES;
        starRatingView.allowsHalfStars = YES;
        [self.view addSubview:starRatingView];
    
    NSString *posterstr =@"http://image.tmdb.org/t/p/w185";
    NSString *imgstr=[posterstr stringByAppendingString:[_movie poster_path]];
    if([_movie poster_path] && ![[_movie poster_path] isKindOfClass:[NSNull class]]){
     [_img sd_setImageWithURL:[NSURL URLWithString:imgstr]
                    placeholderImage:[UIImage imageNamed:@"noimage.png"]];
        NSLog(@"posterPath %@",[_movie poster_path]);
    } else {
        UIImage *image= [UIImage imageNamed:@"noimage.png"];

        [_img setImage:image];
    }
    
    flag= [db findFavMovie:_movie];
    if(flag){
        
        [_btnfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateNormal];
    } else {
        
        [_btnfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateNormal];
    }
    
    

}
- (void)setMovie:(Movies *)movie{
    _movie=movie;
}



- (void)setKey:(NSString *)key{
    _key=key;
    NSString *keystr=[@"youtube://" stringByAppendingString:_key];
    NSURL *str=[NSURL URLWithString:keystr];
    if ([[UIApplication sharedApplication] canOpenURL:str])
    {  [[UIApplication sharedApplication] openURL:str];
        
    } else {
        NSString *keystr=[@"http://www.youtube.com/watch?v=" stringByAppendingString:_key];
        NSURL *str=[NSURL URLWithString:keystr];
        [[UIApplication sharedApplication] openURL:str];
    }
}



- (IBAction)favBtn:(id)sender {
    
    Boolean f;
    flag= [db findFavMovie:_movie];
    if(flag){
        [_btnfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic.png"] forState:UIControlStateHighlighted];
        f=   [db deleteFavMovie:_movie];
        
    } else {
        [_btnfav setBackgroundImage:[UIImage imageNamed:@"favorite_ic_act.png"] forState:UIControlStateHighlighted];
        f= [db insertFavMovie:_movie];
        
    }
}

- (IBAction)videoBtn:(id)sender {
    s=[NSString stringWithFormat:@"%@",[_movie movieId]];
     [net getVideoData:s :self];
}

- (IBAction)reviewsBtn:(id)sender {
    s=[NSString stringWithFormat:@"%@",[_movie movieId]];
     [net getReviewsData:s :self];
   
    
}
- (void)setReviews:(NSMutableArray *)reviews{
    _reviews=reviews;
    rv=[self.storyboard instantiateViewControllerWithIdentifier:@"reviwes"];
    rv.reviews=_reviews;
    [self.navigationController pushViewController:rv animated:YES];
  //  [self.tableView reloadData];
}
@end
