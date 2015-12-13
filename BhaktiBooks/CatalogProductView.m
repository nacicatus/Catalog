//
//  CatalogProductView.m
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import "CatalogProductView.h"

@implementation CatalogProductView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Draw the product text
    
    [theProduct.name drawAtPoint:CGPointMake(45.0, 0.0) forWidth:120 withFont:[UIFont systemFontOfSize:16.0] fontSize:12.0 lineBreakMode:NSLineBreakByTruncatingTail baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
   
    
    // Set to draw in dark gray
    [[UIColor darkGrayColor]set];
    
    // Draw the manufacturer label
    [theProduct.manufacturer drawAtPoint:CGPointMake(45.0, 25.0) forWidth:120 withFont:[UIFont systemFontOfSize:12.0] fontSize:12.0 lineBreakMode:NSLineBreakByTruncatingTail baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Set to draw in black
    [[UIColor blackColor]set];
    
    // Draw the price label
    [[[NSNumber numberWithFloat:theProduct.price]stringValue] drawAtPoint:CGPointMake(200.0, 10.0) forWidth:60 withFont:[UIFont systemFontOfSize:16.0] fontSize:16.0 lineBreakMode:NSLineBreakByTruncatingTail baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Draw the image
    NSString *filePath = [[NSBundle mainBundle] pathForResource:theProduct.image ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    [image drawInRect:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    
    filePath = [[NSBundle mainBundle] pathForResource:theProduct.countryOfOrigin ofType:@"png"];
    image = [UIImage imageWithContentsOfFile:filePath];
    [image drawInRect:CGRectMake(260.0, 10.0, 20.0, 20.0)];
    
}


-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setProduct:(Product*)inputProduct {
    // If a different product is passed in
    if (theProduct != inputProduct) {
        theProduct = inputProduct;
    }
    // Mark the view to be redrawn
    [self setNeedsDisplay];
}

@end
