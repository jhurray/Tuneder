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

@interface TDCardContainer : EZLayoutContainerView

@property (strong, nonatomic, readonly) TDCardView *topCard;

@end
