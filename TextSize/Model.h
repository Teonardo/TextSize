//
//  Model.h
//  TextSize
//
//  Created by Teonardo on 2019/8/22.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

@property (nonatomic, copy) NSString *text;       // 显示的文本
@property (nonatomic, strong) UIFont *font;       // 文本字体
@property (nonatomic, assign) CGFloat textHeight;

@end

NS_ASSUME_NONNULL_END
