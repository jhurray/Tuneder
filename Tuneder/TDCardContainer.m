//
//  TDCardContainer.m
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "TDCardContainer.h"

@interface TDCardContainer()

@property (strong, nonatomic) TDCardView *topCard;
@property (strong, nonatomic) TDCardView *middleCard;
@property (strong, nonatomic) TDCardView *bottomCard;

@end

@implementation TDCardContainer

- (instancetype) init {
    if (self = [super init]) {
        [self layoutUI];
    }
    return self;
}

- (void) addShadowtoView:(UIView *)view {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.frame];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(10.0f, -20.0f);
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowPath = shadowPath.CGPath;
}

- (void) layoutUI {
    self.topCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment top];
        make.frameWasSetBlock = ezFrameWasSetBlock() {
            [self addShadowtoView:self.topCard];
        };
    }];
    
    self.middleCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.05];
        make.frameWasSetBlock = ezFrameWasSetBlock() {
            [self addShadowtoView:self.middleCard];
        };
    }];
    
    self.bottomCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.1];
        make.frameWasSetBlock = ezFrameWasSetBlock() {
            [self addShadowtoView:self.bottomCard];
        };
    }];
    
    self.topCard.tag = 3;
    self.middleCard.tag = 2;
    self.bottomCard.tag = 1;
    
    [self.topCard attachToContainerView:self];
    [self.middleCard attachToContainerView:self];
    [self.bottomCard attachToContainerView:self];
}

- (void) layoutSubviews {
    
}

@end
