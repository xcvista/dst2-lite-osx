//
//  SKSubtitleFile.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SKTrack;

@interface SKSubtitleFile : NSObject

- (NSDictionary *)allMetadata;
- (id)valueForMetadataKey:(NSString *)key;
- (void)setValue:(id)value forMetadataKey:(NSString *)key;
- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;

- (NSArray *)allTracks;
- (SKTrack *)trackAtIndex:(NSUInteger)index;
- (SKTrack *)trackForLocale:(NSLocale *)locale;
- (NSArray *)tracksForLocale:(NSLocale *)locale;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)addTrack:(SKTrack *)track;
- (void)removeTrackAtIndex:(NSUInteger)index;
- (void)removeTracksAtIndexes:(NSIndexSet *)indexSet;

- (id)objectForKeyedSubscript:(id)key; // This method will map to:
                                       // - (id)valueForMetadataKey: and
                                       // - (SKTrack *)trackForLocale:

@end

extern NSString *const SKTitleMetadataKey;
extern NSString *const SKAuthorMetadataKey;
extern NSString *const SKArtistMetadataKey;
extern NSString *const SKAlbumMetadataKey;
extern NSString *const SKDefaultTrackMetadataKey;

@interface SKSubtitleFile (SKCommonMetadata)

- (NSString *)title;
- (void)setTitle:(NSString *)title;

- (NSString *)author;
- (void)setAuthor:(NSString *)author;

- (NSString *)artist;
- (void)setArtist:(NSString *)artist;

- (NSString *)album;
- (void)setAlbum:(NSString *)album;

- (NSUInteger)defaultTrack;
- (void)setDefaultTrack:(NSUInteger)defaultTrack;

@end
