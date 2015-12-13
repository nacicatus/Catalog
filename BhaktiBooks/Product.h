//
//  Product.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
    int ID;
    NSString* name;
    NSString* manufacturer;
    NSString* details;
    float price;
    int quantity;
    NSString* countryOfOrigin;
    NSString* image;
    NSUInteger section;
}

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *manufacturer;
@property (strong, nonatomic) NSString *details;
@property (nonatomic) float price;
@property (nonatomic) int quantity;
@property (strong, nonatomic) NSString *countryOfOrigin;
@property (strong, nonatomic) NSString *image;
@property NSUInteger section;

@end
