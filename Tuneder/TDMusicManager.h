//
//  TDMusicManager.h
//  Tuneder
//
//  Created by Jeff Hurray on 4/3/15.
//  Copyright (c) 2015 jhurray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDMusicManager : NSObject

+(NSArray *) fetchAllPlaylists;

+(NSArray *) fetchAllSongs;

+(NSArray *) fetchAllAlbums;

+(NSArray *) fetchAllArtists;

+(NSArray *) fetchSongsContainting:(NSString *)searchKey;

+(NSArray *) fetchAlbumsContainting:(NSString *)searchKey;

+(NSArray *) fetchArtistsContainting:(NSString *)searchKey;

// ordered artists albums songs
+(NSArray *) fetchAllContaining:(NSString *)searchKey;

@end
