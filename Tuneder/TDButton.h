//
//  TDButton.h
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDButton : UIView

@property (strong,nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (nonatomic) CGFloat cornerRadius;

+ (instancetype) buttonWithAction:(void(^)())action;

@end
