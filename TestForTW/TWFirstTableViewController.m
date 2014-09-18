//
//  TWFirstTableViewController.m
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWFirstTableViewController.h"
#import "TWWebService.h"
#import "factModel.h"
#import "TWTableViewCell.h"
#import "TWCellFrame.h"
#import "TopModel.h"

@interface TWFirstTableViewController (){
    TopModel *_topModel;
    NSMutableArray *_twCellFrames;
    BOOL _isDragging;
    BOOL _isLoading;
    TWWebService *_webService;
}

@end

@implementation TWFirstTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    _twCellFrames = [[NSMutableArray alloc] init];
    _webService = [[TWWebService alloc] init];
    _topModel = [_webService loadJSONData:0];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //NSLog(@"%@",_topModel.title);
    self.title = _topModel.title;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0]};
    if (isIOS7) {
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else{
    
    }
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _topModel.factArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"twCell";
    TWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[TWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle   reuseIdentifier:cellIdentity];
    }
    
    cell.twCellFrame = _twCellFrames[indexPath.row];
    
    return cell;
}

#pragma mark -delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWCellFrame *frame = [[TWCellFrame alloc] init];
    frame.fact = (factModel *)_topModel.factArray[indexPath.row];
    [_twCellFrames addObject:frame];
   
    return frame.cellHeight;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(_isLoading)return;
    _isDragging=YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(_isLoading)return;
    _isDragging = NO;
    if(scrollView.contentOffset.y<-45){
        UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Refreshing..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        TopModel *newTop = [_webService loadJSONData:0];
        _topModel = newTop;
        self.title = _topModel.title;
        [self.tableView reloadData];
        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        
        
    }
}




@end
