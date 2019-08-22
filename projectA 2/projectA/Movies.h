//
//  Movies.h
//  projectA
//
//  Created by Lost Star on 4/7/19.
//

#import <Foundation/Foundation.h>


@interface Movies : NSObject


   @property    NSString *rating;
   @property    NSString *title;
   @property    NSString *poster_path;
   @property    NSString *overview;
   @property    NSString *release_date;
   @property    NSString *movieId;

-(id)initWithDictionary: (NSDictionary *) dictionary;

@end


