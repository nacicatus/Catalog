//
//  CatalogTableViewCell.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "CatalogProductView.h"

@interface CatalogTableViewCell : UITableViewCell {
    
}

@property (nonatomic,strong) CatalogProductView* catalogProductView;

- (void)setProduct:(Product *)theProduct;

@end
