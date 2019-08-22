//
//  NSString+LYSize.h
//  TextSize
//
//  Created by Teonardo on 2019/8/22.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYSize)

/**
 获取文本size

 @param size 限制文本绘制的尺寸
 @param font 文本绘制所用字体
 @return 文本绘制结果边界矩形的大小
 */
- (CGSize)ly_boundingRectWithSize:(CGSize)size font:(UIFont *)font;

/**
 获取限定宽度下文本的size

 @param width 限制文本的宽度
 @param font 文本绘制所用字体
 @return 文本绘制结果边界矩形的大小
 */
- (CGSize)ly_boundingRectWithWidth:(CGFloat)width font:(UIFont *)font;

/**
 获取限定高度下文本的size

 @param height 限制文本的高度
 @param font 文本绘制所用字体
 @return 文本绘制结果边界矩形的大小
 */
- (CGSize)ly_boundingRectWithHeight:(CGFloat)height font:(UIFont *)font;

/**
 获取限定宽度下文本的高度

 @param width 限制文本的高度
 @param font 文本绘制所用字体
 @return 文本绘制结果边界矩形的高度
 */
- (CGFloat)ly_heightForBoundingRectWithWidth:(CGFloat)width font:(UIFont *)font;

/**
 获取限定高度下文本的宽度

 @param height 限制文本的高度
 @param font 文本绘制所用字体
 @return 文本绘制结果边界矩形的宽度
 */
- (CGFloat)ly_widthForBoundingRectWithHeight:(CGFloat)height font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
