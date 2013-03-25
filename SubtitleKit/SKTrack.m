//
//  SKTrack.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKTrack.h"
#import "SKLine.h"

@interface SKTrack ()

@property NSMutableArray *lines;

@end

@implementation SKTrack

- (id)init
{
    return [self initWithLocale:nil];
}

- (id)initWithLocale:(NSLocale *)locale
{
    if (self = [super init])
    {
        self.subtitleFile = nil;
        self.locale = locale;
        self.lines = [NSMutableArray array];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    SKTrack *newTrack = [[[self class] alloc] initWithLocale:self.locale];
    newTrack.lines = [self.lines mutableCopy];
    return newTrack;
}

- (instancetype)deepCopy
{
    SKTrack *newTrack = [[[self class] alloc] initWithLocale:self.locale];
    for (SKLine *line in self.lines)
    {
        [newTrack addLine:line];
    }
    return newTrack;
}

- (NSArray *)allLines
{
    return [self.lines copy];
}

- (SKLine *)lineAtIndex:(NSUInteger)index
{
    return self.lines[index];
}

- (SKLine *)lineAtTime:(NSTimeInterval)time
{
    return [self linesAtTime:time][0];
}

- (NSArray *)linesAtTime:(NSTimeInterval)time
{
    NSMutableArray *lines = [NSMutableArray array];
    for (SKLine *line in self.lines)
    {
        if (time > line.startTime && time - line.startTime < line.duration)
            [lines addObject:line];
    }
    return lines;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    return self.lines[index];
}

- (void)addLine:(SKLine *)line
{
    [self willChangeValueForKey:@"lines"];
    SKLine *newLine = (line.track) ? [line copy] : line;
    [self.lines addObject:newLine];
    [self didChangeValueForKey:@"lines"];
}

- (void)setLine:(SKLine *)line atIndex:(NSUInteger)index
{
    [self willChangeValueForKey:@"lines"];
    SKLine *newLine = (line.track) ? [line copy] : line;
    self.lines[index] = newLine;
    [self didChangeValueForKey:@"lines"];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index
{
    [self setLine:object atIndex:index];
}

- (void)sortLines
{
    [self.lines sortUsingSelector:@selector(compare:)];
}

@end
