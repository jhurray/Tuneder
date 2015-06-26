//
//  TDCardView.m
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "TDCardView.h"
#import "EZLayout.h"
#import "UIColor+Theme.h"

@interface TDCardView()

@property (strong, nonatomic) UIImageView *albumView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *artistLabel;

@end

@implementation TDCardView

- (instancetype) init {
    if (self = [super init]) {
        [self layoutUI];
        [self setupUI];
        [self setupGestureRecognizer];
    }
    return self;
}

- (void) setupGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    
    [self addGestureRecognizer:self.panGestureRecognizer];
}

- (void) setupUI {
    
    self.backgroundColor = [UIColor mainColor];
    self.layer.cornerRadius = 8.0;
    
    self.artistLabel.text = @"Artist";
    self.artistLabel.textAlignment = NSTextAlignmentCenter;
    self.artistLabel.font = [UIFont systemFontOfSize:14.0];
    self.artistLabel.adjustsFontSizeToFitWidth = YES;
    
    self.titleLabel.text = @"Song title";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.albumView.backgroundColor = [UIColor themeColor];
    self.albumView.image = [UIImage imageNamed:@"default_album"];
}

- (void) layoutUI {
    self.albumView = [UIImageView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 scaleFactor:1.0];
        make.layer.cornerRadius = 8.0;
        make.layer.masksToBounds = YES;
    }];
    
    self.titleLabel = [UILabel ezMakeBasic];
    self.artistLabel = [UILabel ezMakeBasic];
    self.titleLabel.ezSize.widthPercentage = 0.9;
    self.artistLabel.ezSize.widthPercentage = 0.9;
    [self verticallyLayoutViews:@[self.albumView, self.titleLabel, self.artistLabel]
                withPercentages:@[@0.7, @0.15, @0.15]];
}

- (void) setMediaItem:(MPMediaItem *)mediaItem {
    _mediaItem = mediaItem;
    NSString *artistString = mediaItem.artist ? mediaItem.artist : @"Unknown Artist";
    NSString *titleString = mediaItem.title ? mediaItem.title : @"Unknown Title";
    self.artistLabel.text = artistString;
    self.titleLabel.text = titleString;
    UIImage *albumImage = [mediaItem.artwork imageWithSize:self.albumView.frame.size];
    self.albumView.image = albumImage ? albumImage : [UIImage imageNamed:@"default_album"];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    if (self.mediaItem) {
        UIImage *albumImage = [_mediaItem.artwork imageWithSize:self.albumView.frame.size];
        self.albumView.image = albumImage ? albumImage : [UIImage imageNamed:@"default_album"];
    }
    [self addShadowtoView:self];
}

- (void) addShadowtoView:(UIView *)view {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor themeColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-8.0f, 15.0f);
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowPath = shadowPath.CGPath;
}

@end
