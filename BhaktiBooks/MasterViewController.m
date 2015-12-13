//
//  MasterViewController.m
//  BhaktiBooks
//
//  Created by Saurabh Sikka on 14/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CatalogTableViewCell.h"

#define NAMELABEL_TAG 1
#define MANUFACTURER_TAG 2
#define PRICELABEL_TAG 3
#define PRODUCTIMAGE_TAG 4
#define FLAGIMAGE_TAG 5

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController
@synthesize searchBar, searchController, filteredProducts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Catalog", @"Catalog");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.products = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *productsTemp;
    
    //  Get the DBAccess object;
    DBAccess *dbAccess = [[DBAccess alloc] init];
    
    //  Get the products array from the database
    //self.products = [dbAccess getAllProducts];
    productsTemp = [dbAccess getAllProducts];
    
    //  Close the database because we are finished with it
    [dbAccess closeDatabase];
    
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    
    // Iterate over products, populating their section number
    for (Product *theProduct in productsTemp) {
        NSInteger section = [indexedCollation sectionForObject:theProduct collationStringSelector:@selector(name)];
        theProduct.section = section;
    }
    
    // Get the count of the number of sections
    NSInteger sectionCount = [[indexedCollation sectionTitles] count];
    
    // Create an array to hold the sub arrays
    NSMutableArray *sectionsArray = [NSMutableArray arrayWithCapacity:sectionCount];
    
    // Iterate over each section, creating each sub array
    for (int i=0; i<=sectionCount; i++) {
        NSMutableArray *singleSectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionsArray addObject:singleSectionArray];
    }
    
    // Iterate over the products, putting each product into the correct sub array
    for (Product *theProduct in productsTemp) {
        [(NSMutableArray *)[sectionsArray objectAtIndex:theProduct.section] addObject:theProduct];
        
    }
    
    // Iterate over each section array to sort the items in the section
    for (NSMutableArray *singleSectionArray in sectionsArray) {
        NSArray *sortedSection = [indexedCollation sortedArrayFromArray:singleSectionArray collationStringSelector:@selector(name)];
        [self.products addObject:sortedSection];
    }
    
    
    // Search Bar & Controller
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    self.tableView.tableHeaderView = self.searchBar;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return [self.products count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[self.products objectAtIndex:section] count];
    }
    // You need the count of the filtered table by flattening the array
    NSMutableArray *flattenedArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSMutableArray *theArray in self.products) {
        for (int i = 0; i < [theArray count]; i++) {
            [flattenedArray addObject:[theArray objectAtIndex:i]];
        }
    }
    // Set up NSPredicate to filter the rows
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", self.searchBar.text];
    self.filteredProducts = [flattenedArray filteredArrayUsingPredicate:predicate];
    
    return self.filteredProducts.count;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CatalogTableViewCell *cell = (CatalogTableViewCell *)[tableView
                                                          dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CatalogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Is the request for cellForRowAtIndexPath for the regular table?
    if (tableView == self.tableView) {
        // Get the Product object
        Product* product = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        [cell setProduct:product];
        
        return cell;
    }
    // Get the Product object, set it and return
    Product* product = [self.filteredProducts objectAtIndex:[indexPath row]];
    [cell setProduct:product];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Now that we're using headers in our table we need to check if the header contains data
/*
 In Swift this checking is the basis of the whole Optional (if let) unwrapping method
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Make sure the section contains some data
    if ([[self.products objectAtIndex:section] count] > 0) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // Set up the index titles from the UILocalizedIndexedCollation
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product* product;
    if (tableView == self.tableView) {
        product = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    } else {
        product = [self.filteredProducts objectAtIndex:[indexPath row]];
    }
    
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    self.detailViewController.detailItem = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
