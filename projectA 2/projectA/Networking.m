//
//  Networking.m
//  projectA
//
//  Created by Lost Star on 4/6/19.
//

#import "Networking.h"
#import "ViewController1.h"
#import "DetailesViewController.h"
#import "AFNetworking.h"
#import "Movies.h"
#import "ReviewsTableViewController.h"

@implementation Networking

+(Networking *)sharedInstance{
    
    static Networking *net = nil;
    
    static dispatch_once_t onec_predicate;
    
    
    dispatch_once(&onec_predicate, ^{
        
        net = [Networking new];
        
    });
    
    return net;
    
}



-(void)getConnection : (id) vc and:(NSUInteger)indexPath{
    
    
    _resultsArr=[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL;
    if(indexPath==0)
    {
        URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=ab3a45a607ba9596dbea0458d1bb0131"];
    } else
    {
        URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/discover/movie?api_key=ab3a45a607ba9596dbea0458d1bb0131&sort_by=vote_average.desc"];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            
         NSDictionary *moviedictionary=[responseObject objectForKey:@"results"];
          

            
        for (NSDictionary *dictionary in moviedictionary){
            Movies *movie = [[Movies alloc] initWithDictionary:dictionary];
            [self->_resultsArr addObject: movie];
        }
            [vc setMovies:self->_resultsArr];
        }
    }];
     [dataTask resume];
    
    
}

-(void)getVideoData :(NSString *)str1 :(id) detailsvc{
    _BaseURL =@"http://api.themoviedb.org/3";
    _videos =[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *str =[[[_BaseURL stringByAppendingString:@"/movie/"] stringByAppendingString:str1] stringByAppendingString:@"/videos?api_key=ab3a45a607ba9596dbea0458d1bb0131"];
    
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
            
            
            NSString *keyresult =[resultArray objectAtIndex:0][@"key"];
            
           [detailsvc setKey:keyresult];
            
        }
        
        
    }]; [dataTask resume];
    
    
}

-(void)getReviewsData :(NSString *)str1 :(id) detailsvc{
    _BaseURL =@"http://api.themoviedb.org/3";
    _videos =[NSMutableArray new];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *str =[[[_BaseURL stringByAppendingString:@"/movie/"] stringByAppendingString:str1] stringByAppendingString:@"/reviews?api_key=ab3a45a607ba9596dbea0458d1bb0131"];
    
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"results"];
            
            [detailsvc setReviews:resultArray];
            
        }
        
        
    }]; [dataTask resume];
    
    
}

@end
