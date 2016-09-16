//
//  ViewController.m
//  SYSearchController
//
//  Created by Saucheong Ye on 16/09/2016.
//  Copyright © 2016 sauchye.com All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITabBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *searchData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableArray new];
    self.searchData = [NSMutableArray new];
    self.tableView.tableFooterView = [UIView new];
    NSArray *datas = @[@"Apple", @"Google", @"Facebook", @"Amzon", @"Yahoo", @"..."];
    self.data = [NSMutableArray arrayWithArray:datas];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.searchController = ({
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
        searchController.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44.f);
        searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchController.searchBar.barTintColor = [UIColor clearColor];
        searchController.searchBar.tintColor = [UIColor whiteColor];
//        searchController.hidesNavigationBarDuringPresentation = NO;
        UITextField *searchField = [searchController.searchBar valueForKey:@"_searchField"];
        searchField.textColor    = [UIColor whiteColor];
        self.tableView.tableHeaderView = searchController.searchBar;
        searchController;
    });
    
}

#pragma mark - updateFilteredContent
- (void)updateFilteredContent:(NSString *)searchString {
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (self.searchData != nil) {
        [self.searchData removeAllObjects];
    }
    
    self.searchData = [NSMutableArray arrayWithArray:[self.data filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [self updateFilteredContent:searchController.searchBar.text];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        return self.searchData.count;
    }
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    NSString *title = nil;
    if (self.searchController.active) {
        title = [self.searchData objectAtIndex:indexPath.row];
    }else{
        title = [self.data objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"XXXXX";
    return  cell;
}


@end
