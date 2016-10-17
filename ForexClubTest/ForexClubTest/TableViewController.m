//
//  TableViewController.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "TableViewController.h"
#import "EPApiManager+MessageRequest.h"

@interface TableViewController (){
    NSArray *dataArray;
    CGRect originalCellSize;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    EPApiManager *manager = [EPApiManager new];
    [manager getMessages:^(NSArray *messages, EPMessageInfo *messageInfo) {
        NSLog(@"%s messages:%@ \n info:%@",__PRETTY_FUNCTION__,messages,messageInfo);
        dataArray = messages;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    EPMessage *message = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = message.messageText;
    
    // Configure the cell...
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"I'm Highlighted at %ld",(long)indexPath.row);
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    originalCellSize = cell.frame;
    
    //Using animation so the frame change transform will be smooth.
    
    [UIView animateWithDuration:0.1f animations:^{
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height+40);
    }];
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"I'm Unhighlighted at %ld",(long)indexPath.row);

    
    [UIView animateWithDuration:0.1f animations:^{
        cell.frame = originalCellSize;
    }];
    
//    originalCellSize = CGRectMake(0, 0, 0, 0);
}


@end
