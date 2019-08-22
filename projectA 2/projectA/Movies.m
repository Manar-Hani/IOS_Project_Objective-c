//
//  Movies.m
//  projectA
//
//  Created by Lost Star on 4/7/19.
//

#import "Movies.h"

@implementation Movies

-(id)initWithDictionary: (NSDictionary *) dictionary{
    
    self = [super init];
    if (self != nil){
    
    _rating =[dictionary objectForKey:@"vote_average"];
    _title=[dictionary objectForKey:@"title"];
    _poster_path=[dictionary objectForKey:@"poster_path"];
    _overview=[dictionary objectForKey:@"overview"];
    _release_date=[dictionary objectForKey:@"release_date"];
    _movieId=[dictionary objectForKey:@"id"];
    
    }
    
    return self;

}





@end

