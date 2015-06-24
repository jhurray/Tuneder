//
//  TDMusicManager.m
//  Tuneder
//
//  Created by Jeff Hurray on 4/3/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

@import MediaPlayer;
#import "TDMusicManager.h"

@implementation TDMusicManager

+(NSArray *) fetchAllSongs {
    return [[MPMediaQuery songsQuery] items];
}

+(NSArray *) fetchAllAlbums {
    return [[MPMediaQuery albumsQuery] collections];
}

+(NSArray *) fetchAllPlaylists {
    return [[MPMediaQuery playlistsQuery] collections];
}

+(NSArray *) fetchAllArtists {
    return [[MPMediaQuery artistsQuery] collections];
}

+(NSArray *) fetchSongsContainting:(NSString *)searchKey {
    MPMediaQuery *query = [MPMediaQuery songsQuery];
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:searchKey
                                                               forProperty:MPMediaItemPropertyTitle
                                                            comparisonType:MPMediaPredicateComparisonContains]];
    return [query items];
}

+(NSArray *) fetchAlbumsContainting:(NSString *)searchKey {
    MPMediaQuery *query = [MPMediaQuery albumsQuery];
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:searchKey
                                                               forProperty:MPMediaItemPropertyAlbumTitle
                                                            comparisonType:MPMediaPredicateComparisonContains]];
    return [query collections];
}

+(NSArray *) fetchArtistsContainting:(NSString *)searchKey {
    MPMediaQuery *query = [MPMediaQuery artistsQuery];
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:searchKey
                                                               forProperty:MPMediaItemPropertyArtist
                                                            comparisonType:MPMediaPredicateComparisonContains]];
    return [query collections];
}

+(NSArray *) fetchAllContaining:(NSString *)searchKey {
    return @[[self fetchArtistsContainting:searchKey],
             [self fetchAlbumsContainting:searchKey],
             [self fetchSongsContainting:searchKey]];
}


@end
