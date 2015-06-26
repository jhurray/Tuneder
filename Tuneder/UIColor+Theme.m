//
//  UIColor+Theme.m
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *) mainColor {
    return [UIColor whiteColor];
}

+ (UIColor *) themeColor {
    return [UIColor colorWithRed:150./255. green:100./255. blue:200./255 alpha:1.0];
}

@end
