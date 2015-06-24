//
//  TDCardContainer.h
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZLayout.h"
#import "TDCardView.h"

@protocol TDCardContainerDelegate <NSObject>

- (void) cardWasSwipedLeft:(TDCardView *)card;
- (void) cardWasSwipedRight:(TDCardView *)card;

@end

@interface TDCardContainer : EZLayoutContainerView

- (void) swipeLeft;

@property (strong, nonatomic, readonly) TDCardView *topCard;

@property (weak, nonatomic) id<TDCardContainerDelegate> delegate;

@end
