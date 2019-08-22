//
//  ViewController1.m
//  projectA
//
//  Created by iOS Training on 4/2/19.
//
//

#import "ViewController1.h"
#import "Networking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movies.h"
#import "DetailesViewController.h"
#import <PFNavigationDropdownMenu.h>



@interface ViewController1 (){
   
    Networking *net ;
    NSString *path;
   // Movies *movie;
    DetailesViewController *vc;
    Movies *m;
    
}
    

@end

@implementation ViewController1



- (void)viewDidLoad {
    [super viewDidLoad];
   _movies = [NSMutableArray new];
    [_myCollection setDelegate:self];
    [_myCollection setDataSource:self];
    net=[Networking new];
    m=[Movies new];
    NSArray* items = @[@"Most Popular", @"Top Rated"];
    
    PFNavigationDropdownMenu *menuView = [[PFNavigationDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 300, 44)title:items[0] items:items containerView:self.view];
    
    menuView.didSelectItemAtIndexHandler = ^(NSUInteger indexPath){
        NSLog(@"Did select item at index: %ld", indexPath);
//        self.selectedCellLabel.text = items[indexPath];
        self.title=items[indexPath];
        [net getConnection:self and:indexPath];
        
    };
    
    self.navigationItem.titleView = menuView;
//      self.navigationItem.title=@"Sort By";
    
    }

- (void)viewWillAppear:(BOOL)animated{
    [net getConnection:self and:0];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)setMovies:(NSMutableArray *)movies{
    _movies=movies;
    printf("TEST\n");
    [self.myCollection reloadData];
    printf("TEST2\n");

    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger numofCell=0;
    if([_movies count]!=0){
        numofCell=[_movies count];
    }
    
    return numofCell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //UILabel *movietitle =[cell viewWithTag:3];
    printf("TEST3\n");
    UIImageView *img=[cell viewWithTag:3];
    NSString *link = @"http://image.tmdb.org/t/p/w185/";
    NSString *str=[_movies[indexPath.row] poster_path];
    NSURL *url = [NSURL URLWithString:link];
    if (str == nil || [str isKindOfClass:[NSNull class]]) {
        //do something
    }else{

        url = [NSURL URLWithString:[link stringByAppendingString:str]];
    }

    [img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage.png"]];
    
    
    

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        m=_movies[indexPath.item];
       // [vc setMovie:m];
    NSLog(@"%@", m.title);
    NSLog(@"%@", m.overview);
    NSLog(@"%@", m.release_date);
    NSLog(@"%@", m.rating);
    NSLog(@"%@", m.poster_path);
       [self performSegueWithIdentifier:@"togodetalis" sender:self];
        
    }
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if([segue.identifier isEqualToString:@"togodetalis"]) {
    vc = segue.destinationViewController;
            vc.movie=m;
           
        }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat devWidth;
    CGSize size;
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        devWidth = self.view.bounds.size.width;
        size = CGSizeMake((devWidth/3),210.0);
    }else{
        devWidth = self.view.frame.size.width;
        size = CGSizeMake((devWidth/2),190.0);
    }
    return size;
}

@end
