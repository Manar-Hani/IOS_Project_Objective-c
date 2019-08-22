//
//  FavtoriteViewController.m
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import "FavtoriteViewController.h"
#import "FavDetailsViewController.h"



@interface FavtoriteViewController (){
    
    DataBase *db;
    NSMutableArray *favmovies;
    Boolean b;
    Movies *m;
    FavDetailsViewController *vc;
}

@end

@implementation FavtoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_mytable setDelegate:self];
    [_mytable setDataSource:self];
    
    db=[DataBase sharedInstance];
    favmovies=[NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    favmovies=[db selectFavMovies];
    [_mytable reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSUInteger numOfSection= 1;
    if([favmovies count] !=0){
        
        numOfSection=1;
    }
    
    return numOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfItems=0;
    if([favmovies count]!=0){
        numOfItems=[favmovies count];
    }
    return numOfItems;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favCell" forIndexPath:indexPath];
    Movies *movie=favmovies[indexPath.row] ;
    cell.textLabel.text=movie.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        b=[db deleteFavMovie:favmovies[indexPath.row]];
        
        if(b){
            [favmovies removeObjectAtIndex:indexPath.row];
        }
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    vc=[self.storyboard instantiateViewControllerWithIdentifier:@"fvc"];
    m=favmovies[indexPath.row];
    [vc setMovie:m];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
