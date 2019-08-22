//
//  ReviewsTableViewController.m
//  projectA
//
//  Created by Lost Star on 4/15/19.
//

#import "ReviewsTableViewController.h"

@interface ReviewsTableViewController (){
    UILabel *author;
    UITextView *content1;
    Boolean b;
}

@end

@implementation ReviewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([_reviews count]==0){
        
        b=true;
        
    }else{
        b=false;
    }
    
    printf("TEST\n");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 1;
//    if ([_reviews count] != 0)
//    {
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//
//        [_noReviewsView setHidden:YES];
//
//
//    }
//    else
//    {
//        [_noReviewsView setHidden:NO];
//
//    }
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numOfRows=1;
    if([_reviews count] != 0){
        numOfRows=[_reviews count];
    }
    
    return numOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    printf("cell\n");
    
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    printf("after cell \n");
    author=[cell viewWithTag:10];
    content1=[cell viewWithTag:11];
    
    if(b==false){

    author.text=_reviews[indexPath.row][@"author"];
    content1.text=_reviews[indexPath.row][@"content"];

    }else{
        author.text=@"NO REVIEWS AVALIBLE";
        content1.text=@"";
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}





@end
