//
//  TDPickerViewController.m
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "TDPickerViewController.h"
#import "EZLayout.h"
#import "TDButton.h"
#import "UIColor+Theme.h"
#import "TDCardContainer.h"
#import "TDCardView.h"

@interface TDPickerViewController()

@property (strong, nonatomic) TDButton *yesButton;
@property (strong, nonatomic) TDButton *noButton;
@property (strong, nonatomic) TDButton *playButton;
@property (strong, nonatomic) TDCardContainer *cardContainer;

@end

@implementation TDPickerViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void) setupViews {
    
    self.yesButton = [TDButton buttonWithAction:^{
        
    }];
    
    self.noButton = [TDButton buttonWithAction:^{
        
    }];
    
    self.playButton = [TDButton buttonWithAction:^{
        
    }];
    
    self.noButton.title = @"NO";
    self.noButton.ezSize = [EZLayoutSize widthPercentage:0.6 scaleFactor:1.0];
    self.yesButton.title = @"YES";
    self.yesButton.ezSize = [EZLayoutSize widthPercentage:0.6 scaleFactor:1.0];
    self.playButton.title = @"PLAY";
    self.playButton.ezSize = [EZLayoutSize widthPercentage:0.8 scaleFactor:1.0];
    
    self.cardContainer = [TDCardContainer ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
    }];
    
    EZLayoutContainerView *buttons = [EZLayoutContainerView container];
    [buttons horizontallyLayoutViews:@[_noButton, _playButton, _yesButton]
                     withPercentages:@[kEZThird, kEZThird, kEZThird]];
    
    EZLayoutContainerView *base = [EZLayoutContainerView containerWithViewController:self];
    [base verticallyLayoutViews:@[_cardContainer, buttons] withPercentages:@[@0.7, @0.3]];
}

@end
