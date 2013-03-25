//
//  SKOffsetting.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKOffsetting.h"
#import "SKTrack.h"
#import "SKLine.h"

NSString *const SKOffsetMetadataKey = @"offset";

@interface SKTrack (SKOffsetting)

- (void)applyOffset:(NSTimeInterval)offset;

@end

@implementation SKSubtitleFile (SKOffsetting)

- (void)applyOffset
{
    for (SKTrack *track in [self allTracks])
    {
        [track applyOffset:[self offset]];
    }
}

- (void)setOffset:(NSTimeInterval)offset
{
    self[SKOffsetMetadataKey] = @(offset);
}

- (NSTimeInterval)offset
{
    return [self[SKOffsetMetadataKey] doubleValue];
}

@end
