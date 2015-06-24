//
//  TDCardView.h
//  Tuneder
//
//  Created by Jeff Hurray on 6/23/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import "EZLayoutContainerView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TDCardView : EZLayoutContainerView

@property (strong, nonatomic) MPMediaItem *mediaItem;

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@end
