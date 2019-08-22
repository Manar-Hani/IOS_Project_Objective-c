//
//  FavtoriteViewController.h
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"
#import "Movies.h"



@interface FavtoriteViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property NSMutableArray *movies;



@end


