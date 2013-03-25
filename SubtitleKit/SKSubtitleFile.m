//
//  SKSubtitleFile.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKSubtitleFile.h"
#import "SKTrack.h"

@interface SKSubtitleFile ()

@property NSMutableArray *_tracks;
@property NSMutableDictionary *_metadata;

@end

@implementation SKSubtitleFile

- (id)init
{
    if (self = [super init])
    {
        self._tracks = [NSMutableArray array];
        self._metadata = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary *)metadata
{
    return [self._metadata copy];
}

- (id)valueForMetadataKey:(NSString *)key
{
    return self._metadata[key];
}

- (void)setValue:(id)value forMetadataKey:(NSString *)key
{
    [self willChangeValueForKey:key];
    self._metadata[key] = value;
    [self didChangeValueForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key
{
    [self willChangeValueForKey:key];
    self._metadata[key] = object;
    [self didChangeValueForKey:key];
}

- (NSArray *)tracks
{
    return [self._tracks copy];
}

- (SKTrack *)trackForLocale:(NSLocale *)locale
{
    return [self tracksForLocale:locale][0];
}

- (NSArray *)tracksForLocale:(NSLocale *)locale
{
    NSMutableArray *tracks = [NSMutableArray arrayWithCapacity:[self._tracks count]];
    for (SKTrack *track in self._tracks)
    {
        if ([track.locale isEqual:locale])
            [tracks addObject:track];
    }
    return tracks;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    return self._tracks[index];
}

- (void)addTrack:(SKTrack *)track
{
    [self._tracks addObject:track];
}

- (void)removeTrackAtIndex:(NSUInteger)index
{
    [self._tracks removeObjectAtIndex:index];
}

- (void)removeTracksAtIndexes:(NSIndexSet *)indexSet
{
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop)
    {
        [self._tracks removeObjectAtIndex:index];
    }];
}

- (id)objectForKeyedSubscript:(id)key
{
    if ([key isKindOfClass:[NSLocale class]])
    {
        return [self trackForLocale:key];
    }
    else
    {
        return [self valueForMetadataKey:key];
    }
}

@end

NSString *const SKTitleMetadataKey = @"title";
NSString *const SKAuthorMetadataKey = @"author";
NSString *const SKArtistMetadataKey = @"artist";
NSString *const SKAlbumMetadataKey = @"album";
NSString *const SKDefaultTrackMetadataKey = @"default-track";

@implementation SKSubtitleFile (SKCommonMetadata)

- (NSString *)title
{
    return self[SKTitleMetadataKey];
}

- (void)setTitle:(NSString *)title
{
    self[SKTitleMetadataKey] = title;
}

- (NSString *)author
{
    return self[SKAuthorMetadataKey];
}

- (void)setAuthor:(NSString *)author
{
    self[SKAuthorMetadataKey] = author;
}

- (NSString *)artist
{
    return self[SKArtistMetadataKey];
}

- (void)setArtist:(NSString *)artist
{
    self[SKArtistMetadataKey] = artist;
}

- (NSString *)album
{
    return self[SKAlbumMetadataKey];
}

- (void)setAlbum:(NSString *)album
{
    self[SKAlbumMetadataKey] = album;
}

- (NSUInteger)defaultTrack
{
    return [self[SKDefaultTrackMetadataKey] unsignedIntegerValue];
}

- (void)setDefaultTrack:(NSUInteger)defaultTrack
{
    self[SKDefaultTrackMetadataKey] = @(defaultTrack);
}

@end
