//
//  ViewController.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 03.03.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "ViewController.h"
#import "EPBottomPaneView.h"
#import "UIView+Utils.h"
#import "MessageService.h"
#import "EPExpandableCell.h"
#import <MBProgressHUD.h>

@interface ViewController ()<MessageServiceDelegate>{
    BOOL bottomPaneVisible;
    MessageService *service;
}

@property (weak,nonatomic) IBOutlet EPBottomPaneView *bottomPane;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configure];
    [self setupService];
    [self makeRequest];
}

-(void) configure{
    [self configureBottomPane];
    [self configureTableView];
    [self setupNavBarBtn];
}

-(void) configureBottomPane{
    bottomPaneVisible = NO;
    [self.bottomPane showView:bottomPaneVisible animated:NO direction:UIViewHideDirectionDown];
}

-(void) configureTableView{
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([EPExpandableCell class])
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.f;
}

-(void) setupService{
    service = [MessageService new];
    service.delegate = self;
    self.tableView.delegate = service;
    self.tableView.dataSource = service;
}

-(void) setupNavBarBtn{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(pushRightController)];
    self.navigationItem.rightBarButtonItem  = btn;
}

-(void) makeRequest{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [service getData:^(){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    }failure:^(NSError *error){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}

-(void)didSelectMessage:(EPMessage *)message{
    if (!message){
        [self changeBottomPaneVisibility:NO];
        return;
    }
    [self changeBottomPaneVisibility:YES];
    [self.bottomPane setMessage:message];
}

-(void) changeBottomPaneVisibility:(BOOL) visibility{
    if (bottomPaneVisible + visibility){
        [self.bottomPane showView:visibility animated:NO direction:UIViewHideDirectionDown];
        bottomPaneVisible = visibility;
    }
}

-(void) pushRightController{
    UIViewController *vc = [[NSBundle mainBundle] loadNibNamed:@"EPPushedVC" owner:nil options:nil][0];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
