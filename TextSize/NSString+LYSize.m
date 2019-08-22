//
//  NSString+LYSize.m
//  TextSize
//
//  Created by Teonardo on 2019/8/22.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "NSString+LYSize.h"

@implementation NSString (LYSize)

- (CGSize)ly_boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    // 当字符串为空字符串时, 如果使用下面的计算结果, 此时文本高度为 单行文本的高度. 实际应该为 0;
    if (self == nil || [self isEqualToString:@""]) {
        return CGSizeZero;
    }
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

- (CGSize)ly_boundingRectWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self ly_boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) font:font];
}

- (CGSize)ly_boundingRectWithHeight:(CGFloat)height font:(UIFont *)font {
    return [self ly_boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) font:font];
}

- (CGFloat)ly_heightForBoundingRectWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self ly_boundingRectWithWidth:width font:font].height;
}

- (CGFloat)ly_widthForBoundingRectWithHeight:(CGFloat)height font:(UIFont *)font {
    return [self ly_boundingRectWithHeight:height font:font].width;
}



@end
