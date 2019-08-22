//
//  FavDetailsViewController.m
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import "FavDetailsViewController.h"

@interface FavDetailsViewController ()

@end

@implementation FavDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
   
    
   _overview.text=[_movie overview];
    
    _rating.text=[_movie rating];
    
    //NSString *imgstr =[_movie poster_path];
    
    NSString *posterstr =@"http://image.tmdb.org/t/p/w185/";
    if([_movie poster_path] && ![[_movie poster_path] isKindOfClass:[NSNull class]]){
        
        NSString *imgStr= [posterstr stringByAppendingString:[_movie poster_path]];
        
        [_img sd_setImageWithURL:[NSURL URLWithString:imgStr]
                   placeholderImage:[UIImage imageNamed:@"1.png"]];
    } else {
        UIImage *image= [UIImage imageNamed:@"noimage.png"];
        
        [_img setImage:image];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
