//
//  DBAccess.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <Foundation/Foundation.h>

// This includes the header for the SQLite library.
#import <sqlite3.h>
#import "Product.h"

@interface DBAccess : NSObject {
    
    
}

- (NSMutableArray*) getAllProducts;
- (void) closeDatabase;
- (void)initializeDatabase;

@end
