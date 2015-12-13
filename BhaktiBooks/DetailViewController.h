//
//  DetailViewController.h
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *manufacturerLabel;

@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;

@property (strong, nonatomic) IBOutlet UILabel *countryLabel;





//@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
//@property (strong, nonatomic) IBOutlet UILabel* manufacturerLabel;
//@property (strong, nonatomic) IBOutlet UILabel* detailsLabel;
//@property (strong, nonatomic) IBOutlet UILabel* priceLabel;
//@property (strong, nonatomic) IBOutlet UILabel* quantityLabel;
//@property (strong, nonatomic) IBOutlet UILabel* countryLabel;

@property (strong, nonatomic) id detailItem;


@end
