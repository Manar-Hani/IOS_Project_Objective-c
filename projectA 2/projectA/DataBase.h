//
//  DataBase.h
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movies.h"

@interface DataBase : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

-(id)init;
+(DataBase*) sharedInstance;
-(Boolean)insertMovie :(Movies *)m;
-(Boolean)insertFavMovie :(Movies *)m;
-(NSMutableArray*)selectMovies;
-(NSMutableArray*)selectFavMovies;
-(Boolean)findFavMovie:(Movies *)m;
-(Boolean)deletemovie :(Movies*) m;
-(Boolean)deleteFavMovie :(Movies*) m ;
-(Boolean)removeall;

@end


