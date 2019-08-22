//
//  Networking.h
//  projectA
//
//  Created by Lost Star on 4/6/19.
//

#import <Foundation/Foundation.h>


@interface Networking : NSObject

-(void)getConnection : (id) vc and: (NSUInteger) indexPath;
-(void)getVideoData :(NSString *)str1 :(id) detailsvc;
-(void)getReviewsData :(NSString *)str1 :(id) detailsvc;

+(Networking *)sharedInstance;

@property NSMutableArray *resultsArr;
@property NSMutableArray *videos;
@property NSString *BaseURL;
@end


