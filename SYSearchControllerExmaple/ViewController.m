//
//  ViewController.m
//  SYSearchController
//
//  Created by Saucheong Ye on 16/09/2016.
//  Copyright © 2016 sauchye.com All rights reserved.
//

#import "ViewController.h"
#import "SearchResultController.h"

@interface ViewController () <UITableViewDataSource, UITabBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *searchResults;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];

    self.dataList = [NSMutableArray new];
    self.searchResults = [NSMutableArray new];
    self.tableView.tableFooterView = [UIView new];
    NSArray *datas = @[@"Apple", @"Google", @"Facebook", @"Amzon", @"Yahoo", @"..."];
    self.dataList = [NSMutableArray arrayWithArray:datas];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.searchController = ({
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
        searchController.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44.f);
        searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//        searchController.searchBar.barTintColor = [UIColor clearColor];
//        searchController.searchBar.tintColor = [UIColor whiteColor];
//        searchController.hidesNavigationBarDuringPresentation = NO;
//        UITextField *searchField = [searchController.searchBar valueForKey:@"_searchField"];
//        searchField.textColor    = [UIColor whiteColor];
        self.tableView.tableHeaderView = searchController.searchBar;
        searchController;
    });
    
}


- (void)searchAction {
    
    //创建用于显示搜索结果的视图控制器
    SearchResultController * resultsVC = [[SearchResultController alloc] initWithStyle:UITableViewStylePlain];
    //UISearchController初始化
    UISearchController * searchController = [[UISearchController alloc] initWithSearchResultsController:resultsVC];
    //设置代理
    searchController.searchResultsUpdater = self;
    //页面跳转
    [self presentViewController:searchController animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating Methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //获取搜索字符串
//    NSString * searchString = searchController.searchBar.text;
    //根据输入的字符串找到和之匹配的字符串
//    [self updateFilteredContent:searchString];
//    if (searchController.searchResultsController) {
//        
//        //获取UISearchController的searchResultsController
//        SearchResultController * resultsVC = (SearchResultController *)searchController.searchResultsController;
//        //将符合条件的数据赋值给searchResultsController
//        resultsVC.searchResults = self.searchResults;
//        [resultsVC.tableView reloadData];
//    }
}

- (void)updateFilteredContent:(NSString *)searchString {
    //利用谓词搜索,设置谓词格式
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    // 在查询之前需要清理或者初始化数组：懒加载
    if (self.searchResults != nil) {
        [self.searchResults removeAllObjects];
    }
    // 生成查询结果数组
    self.searchResults = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        return self.searchResults.count;
    }
    return self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    NSString *title = nil;
    if (self.searchController.active) {
        title = [self.searchResults objectAtIndex:indexPath.row];
    }else{
        title = [self.dataList objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"XXXXX";
    return  cell;
}


@end
