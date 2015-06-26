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
#import "TDMusicManager.h"

@interface TDPickerViewController()<TDCardContainerDelegate, TDCardContainerDatasource>

@property (strong, nonatomic) TDButton *yesButton;
@property (strong, nonatomic) TDButton *noButton;
@property (strong, nonatomic) TDButton *playButton;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) TDCardContainer *cardContainer;
@property (strong, nonatomic) NSMutableArray *mediaItems;
@property (strong, nonatomic) NSMutableArray *yesMediaItems;
@property (strong, nonatomic) NSMutableArray *noMediaItems;

@end

@implementation TDPickerViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupMediaItems];
    [self setupViews];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void) setupViews {
    
    self.yesButton = [TDButton buttonWithAction:^{
        [self.cardContainer swipeRight];
    }];
    
    self.noButton = [TDButton buttonWithAction:^{
        [self.cardContainer swipeLeft];
    }];
    
    self.playButton = [TDButton buttonWithAction:^{
        MPMusicPlayerController *controller = [MPMusicPlayerController systemMusicPlayer];
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:self.yesMediaItems];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        [controller prepareToPlay];
        [controller play];
    }];
    
    self.descriptionLabel = [UILabel ezMakeBasic];
    self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.backgroundColor = [UIColor mainColor];
    self.descriptionLabel.textColor = [UIColor themeColor];
    self.descriptionLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self updateDescriptionLabel];
    
    self.noButton.title = @"NO";
    self.noButton.ezSize = [EZLayoutSize widthPercentage:0.6 scaleFactor:1.0];
    self.yesButton.title = @"YES";
    self.yesButton.ezSize = [EZLayoutSize widthPercentage:0.6 scaleFactor:1.0];
    self.playButton.title = @"PLAY";
    self.playButton.ezSize = [EZLayoutSize widthPercentage:0.8 scaleFactor:1.0];
    
    self.cardContainer = [TDCardContainer ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.8 widthPercentage:0.8];
        make.tag = 100;
    }];
    self.cardContainer.delegate = self;
    self.cardContainer.datasource = self;
    
    EZLayoutContainerView *buttons = [EZLayoutContainerView ezMake:^(UIView *make) {
        make.ezSize = [EZLayoutSize heightPercentage:0.9 widthPercentage:1.0];
        make.ezAlignment = [EZLayoutAlignment top];
    }];
    
    [buttons horizontallyLayoutViews:@[_noButton, _playButton, _yesButton]
                     withPercentages:@[kEZThird, kEZThird, kEZThird]];
    
    EZLayoutContainerView *base = [EZLayoutContainerView containerWithViewController:self];
    [base verticallyLayoutViews:@[_cardContainer, buttons, _descriptionLabel] withPercentages:@[@0.6, @0.3, @0.1]];
}

#pragma mark - Music Management

- (void) updateDescriptionLabel {
    NSString *songDescriptor = self.yesMediaItems.count==1 ? @"song" : @"songs";
    self.descriptionLabel.text = [NSString stringWithFormat:@"%lu %@ chosen", self.yesMediaItems.count, songDescriptor];
}

- (void) setupMediaItems {
    NSArray *songs = [TDMusicManager fetchAllSongs];
    self.mediaItems = [songs mutableCopy];
    for (int i = 0; i < self.mediaItems.count; i++) {
        int randomInt1 = arc4random() % [self.mediaItems count];
        int randomInt2 = arc4random() % [self.mediaItems count];
        [self.mediaItems exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
    self.yesMediaItems = [NSMutableArray new];
    self.noMediaItems = [NSMutableArray new];
}



#pragma mark - TDCardContainerDelegate

- (void) cardWasSwipedLeft:(TDCardView *)card {
    MPMediaItem *mediaItem = [self.mediaItems lastObject];
    [self.noMediaItems addObject:mediaItem];
    [self.mediaItems removeLastObject];
    [self.mediaItems insertObject:mediaItem atIndex:0];
}

- (void) cardWasSwipedRight:(TDCardView *)card {
    MPMediaItem *mediaItem = [self.mediaItems lastObject];
    [self.yesMediaItems addObject:mediaItem];
    [self.mediaItems removeLastObject];
    [self.mediaItems insertObject:mediaItem atIndex:0];
    [self updateDescriptionLabel];
}

#pragma mark - TDCardContainerDatasource

- (MPMediaItem *) itemForTopCard {
    return [self.mediaItems lastObject];
}

- (MPMediaItem *) itemForMiddleCard {
    return [self.mediaItems objectAtIndex:self.mediaItems.count-2];
}

- (MPMediaItem *) itemForBottomCard {
    return [self.mediaItems objectAtIndex:self.mediaItems.count-3];
}

- (MPMediaItem *) itemForCardOnDeck {
    return [self.mediaItems objectAtIndex:self.mediaItems.count-4];
}

@end
