//
//  DataBase.m
//  projectA
//
//  Created by Lost Star on 4/12/19.
//

#import "DataBase.h"

@implementation DataBase{
    
    NSString *docsDir;
    NSArray *dirPaths;
    Boolean flag;
    NSMutableArray *movies;
    Movies *movie;
}

+(DataBase *)sharedInstance{
    
    static DataBase *db = nil;
    
    static dispatch_once_t onec_predicate;
    
    
    dispatch_once(&onec_predicate, ^{
        
        db = [DataBase new];
        
    });
    
    return db;
    
}

-(id)init{
    self=[super init];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"movies.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS MOVIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, OVERVIEW TEXT , RDATE TEXT , RATE TEXT , POSTER TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create movietable");
        }
        
        const char *sql_stmt1 =
        "CREATE TABLE IF NOT EXISTS FAVMOVIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, OVERVIEW TEXT , RDATE TEXT , RATE TEXT , POSTER TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt1, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            printf("Failed to create favtable");
        }
        
        
        sqlite3_close(_contactDB);
    } else {
        printf("Failed to open/create favdatabase");
    }
    
    
    return self;
}

-(Boolean)insertMovie :(Movies *)m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO MOVIES (title, overview,  rdate, rate, poster) VALUES (\"%@\", \"%@\", \"%@\",\"%@\",\"%@\")",
                               m.title, m.overview, m.release_date, m.rating, m.poster_path];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        } else {
            
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    return flag;
}

-(Boolean)insertFavMovie :(Movies *)m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO FAVMOVIES (title, overview, rdate, rate, poster) VALUES (\"%@\", \"%@\", \"%@\", \"%@\",\"%@\")",
                               m.title, m.overview, m.release_date, m.rating, m.poster_path];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        } else {
            
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    return flag;
}



-(NSMutableArray*)selectMovies {
    
    movies=[NSMutableArray new];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT  title, overview, rdate ,rate ,poster FROM movies "];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            { movie =[Movies new];
                
                
                movie.title= [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                                                   statement, 0)];
                
                movie.overview = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 1)];
                
                movie.release_date=[[NSString alloc]
                                   initWithUTF8String:(const char *)
                                   sqlite3_column_text(statement, 2)];
                movie.rating=[[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 3)];
                
                movie.poster_path=[[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 4)];
                
                
                
                [movies addObject:movie];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return movies;
    
}

-(NSMutableArray*)selectFavMovies {
    
    movies=[NSMutableArray new];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT title, overview ,rdate ,rate ,poster FROM favmovies "];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            { movie =[Movies new];
                
                
                movie.title = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                                                   statement, 0)];
                
                movie.overview = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 1)];
                
                movie.release_date=[[NSString alloc]
                                   initWithUTF8String:(const char *)
                                   sqlite3_column_text(statement, 2)];
                movie.rating=[[NSString alloc]
                            initWithUTF8String:(const char *)
                            sqlite3_column_text(statement, 3)];
                
                movie.poster_path=[[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 4)];
                
                [movies addObject:movie];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return movies;
    
}

-(Boolean)findFavMovie:(Movies *)m{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT  title, overview ,rdate ,rate ,poster FROM favmovies WHERE title=\"%@\"",
                              m.title];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                flag=YES;
            } else {
                flag=NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    return flag;
}



-(Boolean)deletemovie :(Movies*) m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM movies WHERE title=\"%@\"",m.title];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            flag=YES;
        } else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;
}

-(Boolean)deleteFavMovie :(Movies*) m {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM favmovies WHERE title=\"%@\"",m.title];
        
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            flag=YES;
        }else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;
}
-(Boolean)removeall {
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        
    {
        
        NSString *deleteSQL = [NSString stringWithFormat:
                               @"DELETE FROM movies "];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            flag=YES;
        } else {
            flag=NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    return flag;
    
}


@end
