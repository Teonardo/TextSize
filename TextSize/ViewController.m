//
//  ViewController.m
//  TextSize
//
//  Created by Teonardo on 2019/8/22.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "ViewController.h"
#import "Masonry/Masonry.h"
#import "Cell.h"
#import "Model.h"
#import "NSString+LYSize.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    
    NSLog(@"SCREEN_WIDTH: %f", SCREEN_WIDTH);
    
    // ⭐️ 测试环境: iPhone XR 模拟器 ⭐️

    // label 测试
//    [self addLabel];
    
    // cell 高度测试
    [self addTableView];
}


#pragma mark - UI
- (void)addLabel {
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor brownColor];
    label.text = @"Wrapping occurs before the first character that doesn’t fit. Lines are simply not drawn past the edge of the text container.";
    
    label.frame = CGRectMake(0, 100, SCREEN_WIDTH, 0);
    
    // a 会自动调整大小, 调用此方法前必须设置了 frame.origin 和 frame.size.width
//    [label sizeToFit];
    
    // b 只计算尺寸, 不自动调整大小
    CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH, 50)];
    label.frame = CGRectMake(0, 100, size.width, size.height);
}

- (void)addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableFooterView = [UIView new];
    tableView.showsVerticalScrollIndicator = NO;
    
    /**
     ① 未如下设置时, cell.contentView高度 = cell高度 - 0.5;
     ② 按如下设置时, cell.contentView高度 = cell高度;
     */
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[Cell class] forCellReuseIdentifier:NSStringFromClass([Cell class])];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"height %ld-%ld", (long)indexPath.section, (long)indexPath.row);
    
    Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell %@", cell); // 此时获取到的 cell 为 nil.
    
    Model *model = self.modelArr[indexPath.row];
    
    /**
     ①若此方法返回值 为非负数, 则 此方法一共会调用3次, 先走 cellForRowAtIndexPath: 方法, 方法内调用 dequeueReusableCellWithIdentifier: 创建 cell 后, return cell 之前会走2次, return cell 之后会走1次.
     ②若此方法返回值 为负数, 则 此方法一共会调用2次, 先走 cellForRowAtIndexPath: 方法, 方法内调用 dequeueReusableCellWithIdentifier: 创建 cell 后, return cell 之前会走1次, return cell 之后会走1次.
     */
    
//    return model.textHeight > 0 ? model.textHeight : 0;
    return model.textHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell %ld-%ld", (long)indexPath.section, (long)indexPath.row);
    
    Model *model = self.modelArr[indexPath.row];
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Cell class]) forIndexPath:indexPath];
    cell.label.text = model.text;
    cell.label.font = model.font;
    
    // 计算高度 并 缓存
    if (model.textHeight == -1) { // model 内部将 textHeight 默认值设置为 -1
        CGFloat cellWidth = SCREEN_WIDTH;
        // 1️⃣
        CGSize size = [cell.label sizeThatFits:CGSizeMake(cellWidth, CGFLOAT_MAX)];
        NSLog(@"计算大小 %@", NSStringFromCGSize(size));
        model.textHeight = size.height + 0.5; // 在使用系统分割线时, 需加上分割线的高度
        
        // 2️⃣
        CGFloat height = [model.text ly_heightForBoundingRectWithWidth:cellWidth font:model.font];
        NSLog(@"height %f", height);
    }
    
    return cell;
}

#pragma mark - Private Method
- (void)prepareData {
    self.modelArr = [NSMutableArray arrayWithCapacity:1];
    Model *model = [Model new];
    model.text = @"Wrapping occurs before the first character that doesn’t fit. Lines are simply not drawn past the edge of the text container.";
//    model.text = @"";
    model.font = [UIFont systemFontOfSize:15];
    [self.modelArr addObject:model];
}

@end
