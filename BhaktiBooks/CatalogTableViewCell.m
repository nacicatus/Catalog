//
//  CatalogTableViewCell.m
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import "CatalogTableViewCell.h"

@implementation CatalogTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Create a frame that matches the size of the custom cell
        
        CGRect viewFrame = CGRectMake(0.0, 0.0,
                                      self.contentView.bounds.size.width,
                                      self.contentView.bounds.size.height);
        
        // Allocate and initialize the custom view with the dimensions
        // of the custom cell
        self.catalogProductView = [[CatalogProductView alloc]
                                   initWithFrame:viewFrame];
        
        // Add our custom view to the cell
        [self.contentView addSubview:self.catalogProductView];
        
    }
    return self;
}


- (void)setProduct:(Product *)theProduct
{
    [self.catalogProductView setProduct:theProduct];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
