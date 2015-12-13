//
//  MasterViewController.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "DBAccess.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    
    UISearchBar* searchBar;
    UISearchDisplayController* searchController;
    NSArray* filteredProducts;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray* products;
@property (retain, nonatomic) UISearchBar* searchBar;
@property (nonatomic, retain)  UISearchDisplayController* searchController;
@property (nonatomic, retain) NSArray* filteredProducts;

@end

