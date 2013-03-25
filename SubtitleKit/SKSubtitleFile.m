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

@property NSMutableArray *tracks;
@property NSMutableDictionary *metadata;

@end

@implementation SKSubtitleFile

- (id)init
{
    if (self = [super init])
    {
        self.tracks = [NSMutableArray array];
        self.metadata = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary *)allMetadata
{
    return [self.metadata copy];
}

- (id)valueForMetadataKey:(NSString *)key
{
    return self.metadata[key];
}

- (void)setValue:(id)value forMetadataKey:(NSString *)key
{
    [self willChangeValueForKey:key];
    self.metadata[key] = value;
    [self didChangeValueForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key
{
    [self setValue:object forMetadataKey:key];
}

- (NSArray *)allTracks
{
    return [self.tracks copy];
}

- (SKTrack *)trackForLocale:(NSLocale *)locale
{
    return [self tracksForLocale:locale][0];
}

- (NSArray *)tracksForLocale:(NSLocale *)locale
{
    NSMutableArray *tracks = [NSMutableArray arrayWithCapacity:[self.tracks count]];
    for (SKTrack *track in self.tracks)
    {
        if (^BOOL(NSLocale *locale1, NSLocale *locale2)
        {
            if (!locale1 && !locale2)
                return YES;
            else
                return [locale isEqual:locale2];
        }
            (track.locale, locale)) // Lambda in if. :)
            [tracks addObject:track];
    }
    return tracks;
}

- (SKTrack *)trackAtIndex:(NSUInteger)index
{
    return self.tracks[index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    return [self trackAtIndex:index];
}

- (void)addTrack:(SKTrack *)track
{
    [self willChangeValueForKey:@"track"];
    SKTrack *newTrack = (track.subtitleFile) ? [track deepCopy] : track;
    newTrack.subtitleFile = self;
    [self.tracks addObject:newTrack];
    [self didChangeValueForKey:@"track"];
}

- (void)removeTrackAtIndex:(NSUInteger)index
{
    [self willChangeValueForKey:@"track"];
    [self.tracks removeObjectAtIndex:index];
    [self didChangeValueForKey:@"track"];
}

- (void)removeTracksAtIndexes:(NSIndexSet *)indexSet
{
    [self willChangeValueForKey:@"track"];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop)
    {
        [self.tracks removeObjectAtIndex:index];
    }];
    [self didChangeValueForKey:@"track"];
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
