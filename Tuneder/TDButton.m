//
//  TDButton.m
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "UIColor+Theme.h"
#import "TDButton.h"
#import "EZLayout.h"

@interface TDButton()

@property (nonatomic, copy) void (^action)();
@property (strong, nonatomic) UIButton *topButton;
@property (strong, nonatomic) UIView *bottomView;
@property (nonatomic) CGFloat separation;

@end

@implementation TDButton

+ (instancetype) buttonWithAction:(void(^)())action {
    TDButton *button = [TDButton ezMakeBasic];
    button.action = action;
    button.separation = 8.0;
    button.tintColor = [UIColor themeColor];
    
    button.bottomView = [UIView ezMakeBasic];
    button.bottomView.backgroundColor = [UIColor themeColor];
    button.bottomView.frame = button.bounds;
    [button addSubview:button.bottomView];
    
    button.topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.topButton setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    button.topButton.backgroundColor = [UIColor mainColor];
    [button addSubview:button.topButton];
    
    [button.topButton addTarget:button action:@selector(touchDownAction) forControlEvents:UIControlEventTouchDown];
    [button.topButton addTarget:button action:@selector(touchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    [button.topButton addTarget:button action:@selector(touchUpOutsideAction) forControlEvents:UIControlEventTouchUpOutside];
    [button.topButton addTarget:button action:@selector(touchUpOutsideAction) forControlEvents:UIControlEventTouchDragOutside];
    
    return button;
}

- (void) touchUpInsideAction {
    [self animateUp];
    if (self.action) {
        self.action();
    }
}

- (void) touchUpOutsideAction {
    [self animateUp];
}

- (void) touchDownAction {
    [self animateDown];
}

- (void) animateUp {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.topButton.frame = self.bounds;
    } completion:nil];
}

- (void) animateDown {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topButton.frame = self.bottomView.frame;
    } completion:nil];
}

- (CGFloat) cornerRadius {
    return self.topButton.layer.cornerRadius;
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
    self.topButton.layer.cornerRadius = cornerRadius;
    self.bottomView.layer.cornerRadius = cornerRadius;
}

- (void) layoutSubviews {
    self.topButton.frame = self.bounds;
    CGRect bottomViewFrame = self.bounds;
    bottomViewFrame.origin.y += self.separation;
    self.bottomView.frame = bottomViewFrame;
}

- (void) setTitle:(NSString *)title {
    [self.topButton setTitle:title forState:UIControlStateNormal];
}

-(NSString *) title {
    return self.topButton.titleLabel.text;
}

- (void) setImage:(UIImage *)image {
    [self.topButton setImage:image forState:UIControlStateNormal];
}

- (UIImage *) image {
    return self.topButton.imageView.image;
}

@end
