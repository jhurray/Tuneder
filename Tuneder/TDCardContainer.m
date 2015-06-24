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
@property (strong, nonatomic) TDCardView *cardOnDeck;

@property (nonatomic) BOOL topCardIsDragging;
@property (nonatomic) CGRect originalTopFrame;
@property (nonatomic) CGRect originalMiddleFrame;
@property (nonatomic) CGRect originalBottomFrame;

@end

@implementation TDCardContainer

- (instancetype) init {
    if (self = [super init]) {
        self.topCardIsDragging = NO;
        [self layoutUI];
        [self.topCard.panGestureRecognizer addTarget:self action:@selector(topCardIsBeingPanned:)];
    }
    return self;
}


- (void) topCardIsBeingPanned:(UIPanGestureRecognizer *)sender {
    
    self.topCardIsDragging = YES;
    
    // move
    CGPoint translation = [sender translationInView:self];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                         sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self];
    
    // rotate
    CGFloat diff = sender.view.center.x - self.ezWidth/2.0;
    //sender.view.transform = CGAffineTransformMakeRotation(diff*0.002);
    
    // Interpolate Bottom cards
    CGFloat percentage = MIN(ABS((self.topCard.center.x - self.ezWidth/2.0)/(self.ezWidth/2.0)), 1.0);
    CGFloat deltaX = percentage*8.0;
    CGFloat deltaY = -0.15*self.ezHeight*percentage;
    CGRect newMiddleFrame = self.originalMiddleFrame;
    newMiddleFrame.origin.x += deltaX;
    newMiddleFrame.origin.y += deltaY;
    CGRect newBottomFrame = self.originalBottomFrame;
    newBottomFrame.origin.x += deltaX;
    newBottomFrame.origin.y += deltaY;
    
    self.middleCard.frame = newMiddleFrame;
    self.bottomCard.frame = newBottomFrame;
    self.cardOnDeck.alpha = percentage*0.7;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [self topCardWasReleasedWithVelocity:[sender velocityInView:self]];
    }
    
}

- (void) topCardWasReleasedWithVelocity:(CGPoint)velocity {
    CGFloat percentage = (self.topCard.center.x - self.ezWidth/2.0)/(self.ezWidth/2.0);
    CGFloat pointOfNoReturn = 0.85;
    NSLog(@"velocity is: %@", NSStringFromCGPoint(velocity));
    if (percentage > pointOfNoReturn || velocity.x > 2000.0) {
        [self topCardSwipedRightWithVelocity:velocity];
    }
    else if (percentage < -pointOfNoReturn || velocity.x < -2000.0) {
        [self topCardSwipedLeftWithVelocity:velocity];
    }
    else {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.4
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.topCard.transform = CGAffineTransformIdentity;
                             self.topCard.frame = self.originalTopFrame;
                             self.middleCard.frame = self.originalMiddleFrame;
                             self.bottomCard.frame = self.originalBottomFrame;
                             self.cardOnDeck.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             self.topCardIsDragging = NO;
                             [self layoutSubviews];
                         }];
    }
}

- (void) topCardSwipedRightWithVelocity:(CGPoint)velocity {
    self.topCard.layer.shadowPath = nil;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         self.topCard.ezX = [UIDevice currentWidth]+self.topCard.ezWidth+50;
                         self.topCard.ezY += velocity.y*0.05;
                         self.middleCard.frame = self.originalTopFrame;
                         self.bottomCard.frame = self.originalMiddleFrame;
                         self.cardOnDeck.alpha = 1.0;
                         
    } completion:^(BOOL finished) {
        [self.delegate cardWasSwipedRight:self.topCard];
        [self swapCards];
        self.topCardIsDragging = NO;
        [self layoutSubviews];
    }];
}

- (void) topCardSwipedLeftWithVelocity:(CGPoint)velocity {
    self.topCard.layer.shadowPath = nil;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         self.topCard.ezX = -(self.topCard.ezWidth+50);
                         self.topCard.ezY += velocity.y*0.05;
                         self.topCard.transform = CGAffineTransformIdentity;
                         self.middleCard.frame = self.originalTopFrame;
                         self.bottomCard.frame = self.originalMiddleFrame;
                         self.cardOnDeck.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         [self.delegate cardWasSwipedLeft:self.topCard];
                         [self swapCards];
                         self.topCardIsDragging = NO;
                         [self layoutSubviews];
                     }];
}

- (void) swapCards {
    self.bottomCard.ezAlignment = self.middleCard.ezAlignment;
    self.middleCard.ezAlignment = self.topCard.ezAlignment;
    [self.topCard removeFromSuperview];
    self.topCard = self.middleCard;
    self.middleCard = self.bottomCard;
    self.bottomCard = self.cardOnDeck;
    self.cardOnDeck = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.3];
        make.alpha = 0.0;
    }];
    self.topCard.tag = 3;
    self.middleCard.tag = 2;
    self.bottomCard.tag = 1;
    self.cardOnDeck.tag = 0;
    [self.cardOnDeck attachToContainerView:self];
    [self.topCard.panGestureRecognizer addTarget:self action:@selector(topCardIsBeingPanned:)];
}

- (void) layoutUI {
    self.topCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment top];
    }];
    
    self.middleCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.15];
    }];
    
    self.bottomCard = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.3];
    }];
    
    self.cardOnDeck = [TDCardView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.ezAlignment = [EZLayoutAlignment topPercentage:0.3];
        make.alpha = 0.0;
    }];
    
    self.topCard.tag = 3;
    self.middleCard.tag = 2;
    self.bottomCard.tag = 1;
    self.cardOnDeck.tag = 0;
    
    [self.topCard attachToContainerView:self];
    [self.middleCard attachToContainerView:self];
    [self.bottomCard attachToContainerView:self];
    [self.cardOnDeck attachToContainerView:self];
}

- (void) layoutSubviews {
    if (self.topCardIsDragging) {
        return;
    }
    
    self.topCard.transform = CGAffineTransformIdentity;
    CGRect frameTop = self.topCard.frame;
    CGRect frameBottom = self. bottomCard.frame;
    frameTop.origin.x = self.middleCard.ezX+8;
    frameBottom.origin.x = self.middleCard.ezX-8;
    self.bottomCard.frame = frameBottom;
    self.topCard.frame = frameTop;
    self.originalTopFrame = frameTop;
    self.originalMiddleFrame = self.middleCard.frame;
    self.originalBottomFrame = self.bottomCard.frame;
    
    self.cardOnDeck.frame = frameBottom;
    self.cardOnDeck.alpha = 0.0;
    
    [self.cardOnDeck ezLayoutSubviews];
    [self.bottomCard ezLayoutSubviews];
    [self.topCard ezLayoutSubviews];
}

@end
