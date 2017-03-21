//
//  SearchResultController.m
//  SYSearchControllerExmaple
//
//  Created by Saucheong Ye on 21/03/2017.
//  Copyright © 2017 sauchye.com. All rights reserved.
//

#import "SearchResultController.h"

@implementation SearchResultController


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"SearchResultsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.searchResults[indexPath.row];
    
    return cell;
}


@end
