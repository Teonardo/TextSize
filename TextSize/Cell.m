//
//  Cell.m
//  TextSize
//
//  Created by Teonardo on 2019/8/22.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "Cell.h"
#import "Masonry/Masonry.h"

@interface Cell ()
@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customUI];
    }
    return self;
}

#pragma mark - UI
- (void)customUI {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.label = label;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor brownColor];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSLog(@"%@", self);
    NSLog(@"%@", self.contentView);
    if (self.frame.size.height == self.contentView.frame.size.height) {
        NSLog(@"在 tableView.separatorStyle = UITableViewCellSeparatorStyleNone 时, cell 的高度与其 contentView 的高度相同");
    } else {
        NSLog(@"在 tableView.separatorStyle != UITableViewCellSeparatorStyleNone 时, cell 的高度与其 contentView 的高度相差 0.5 PT, 故推测 cell 的分割线的高度为 0.5 PT");
    }
}

@end
