//
//  ViewController1.h
//  projectA
//
//  Created by iOS Training on 4/2/19.
//
//

#import <UIKit/UIKit.h>

@interface ViewController1 : UIViewController <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *movies;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;



@end
