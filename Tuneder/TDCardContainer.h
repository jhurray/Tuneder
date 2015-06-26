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

@protocol TDCardContainerDatasource <NSObject>

- (MPMediaItem *) itemForTopCard;
- (MPMediaItem *) itemForMiddleCard;
- (MPMediaItem *) itemForBottomCard;
- (MPMediaItem *) itemForCardOnDeck;

@end

@interface TDCardContainer : EZLayoutContainerView

- (void) swipeLeft;
- (void) swipeRight;

@property (strong, nonatomic, readonly) TDCardView *topCard;

@property (weak, nonatomic) id<TDCardContainerDelegate> delegate;
@property (weak, nonatomic) id<TDCardContainerDatasource> datasource;

@end
