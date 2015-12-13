//
//  CatalogProductView.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CatalogProductView : UIView {
    Product* theProduct;
}

-(void)setProduct:(Product*)inputProduct;

@end
