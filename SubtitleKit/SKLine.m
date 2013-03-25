//
//  SKLine.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKLine.h"

@implementation SKLine

- (id)initWithContent:(id)content startTime:(NSTimeInterval)startTime duration:(NSTimeInterval)duration
{
    if (self = [super init])
    {
        self.content = content;
        self.startTime = startTime;
        self.duration = duration;
    }
    return self;
}

- (id)initWithContent:(id)content startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime
{
    return [self initWithContent:content startTime:startTime duration:endTime - startTime];
}

- (NSTimeInterval)endTime
{
    return self.startTime + self.duration;
}

- (void)setEndTime:(NSTimeInterval)endTime
{
    self.duration = endTime - self.startTime;
}

- (NSComparisonResult)compare:(SKLine *)other
{
    if (self.startTime > other.startTime)
        return NSOrderedDescending;
    else if (self.startTime < other.startTime)
        return NSOrderedAscending;
    else if ([self.content respondsToSelector:@selector(compare:)])
    {
        NSComparisonResult result;
        if ((result = [self.content compare:other.content]) != NSOrderedSame)
            return result;
        else if (self.duration > other.duration)
            return NSOrderedAscending;
        else if (self.duration < other.duration)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }
    else if (self.duration > other.duration)
        return NSOrderedAscending;
    else if (self.duration < other.duration)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

@end
