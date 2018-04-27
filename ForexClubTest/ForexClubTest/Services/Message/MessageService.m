//
//  TableViewController.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "MessageService.h"
#import "EPApiManager+MessageRequest.h"
#import "EPExpandableCell.h"

@interface MessageService (){
    NSArray *dataArray;
}

@property (strong, nonatomic) NSIndexPath *expandedIndexPath;

@end

@implementation MessageService

-(void) getData:(void (^)())success failure:(void (^)(NSError *error))failure{
    EPApiManager *manager = [EPApiManager new];
    [manager getMessages:^(NSArray *messages, EPMessageInfo *messageInfo) {
        dataArray = messages;
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    EPMessage *message = [dataArray objectAtIndex:indexPath.row];
    [cell setModel:message];
    cell.withDetails = [self.expandedIndexPath isEqual:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.expandedIndexPath isEqual:indexPath]) {
        self.expandedIndexPath = nil;
        [self.delegate didSelectMessage:nil];
        [self tableView:tableView closeCellAtIndexPath:indexPath];
        return;
    }
    
    NSIndexPath *prevCell = self.expandedIndexPath;
    self.expandedIndexPath = indexPath;
    [self.delegate didSelectMessage:[dataArray objectAtIndex:indexPath.row]];
    if (prevCell)
        [self tableView:tableView closeCellAtIndexPath:prevCell];
    [self tableView:tableView openCellAtIndexPath:self.expandedIndexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([indexPath isEqual:self.expandedIndexPath]) {
        [cell setSelected:YES animated:NO];
    }
}

-(void)tableView:(UITableView *)tableView openCellAtIndexPath:(NSIndexPath *) indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    EPExpandableCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    [cell openDetails];
    [cell setHighlighted:YES];
}

-(void)tableView:(UITableView *)tableView closeCellAtIndexPath:(NSIndexPath *) indexPath{
    EPExpandableCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    [cell setHighlighted:NO];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [cell closeDetails];
}
@end
