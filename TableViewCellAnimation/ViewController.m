//
//  ViewController.m
//  TableViewCellAnimation
//
//  Created by 惠上科技 on 2019/1/21.
//  Copyright © 2019 惠上科技. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"

#define kCellHeight ceil((kScreenWidth) * 3.0 / 4.0)
#define kScreenWidth ((UIWindow *)[UIApplication sharedApplication].windows.firstObject).width

@interface ImageExampleCell : UITableViewCell
@property (nonatomic, strong) UIImageView *exampleImageView;
@end

@implementation ImageExampleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.size = CGSizeMake(kScreenWidth, kCellHeight);
    self.contentView.size = self.size;
    
    _exampleImageView = [UIImageView new];
    _exampleImageView.size = self.size;
    _exampleImageView.clipsToBounds = YES;
    _exampleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _exampleImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_exampleImageView];
    
    return self;
    
}

@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *exampleTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self scrollViewDidScroll:self.exampleTableView];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = nil;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


-(UITableView *)exampleTableView{
    if (!_exampleTableView) {
        _exampleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _exampleTableView.delegate = self;
        _exampleTableView.dataSource = self;
        _exampleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _exampleTableView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_exampleTableView];
    }
    return _exampleTableView;
}


#pragma mark --------tableViewDelegate
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ImageExampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.exampleImageView.backgroundColor = [UIColor colorWithRed:(random()%255)/255.0 green:(random()%255)/255.0 blue:(random()%255)/255.0 alpha:1.0];
        cell.exampleImageView.layer.cornerRadius = 8;
        cell.exampleImageView.layer.masksToBounds = YES;
    }
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (ImageExampleCell *cell in [self.exampleTableView visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.exampleImageView.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}

@end
