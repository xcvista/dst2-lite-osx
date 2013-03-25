//
//  SKLine.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SKTrack;

@interface SKLine : NSObject <NSCopying>

@property (weak) SKTrack *track;
@property id content;
@property NSTimeInterval startTime;
@property NSTimeInterval duration;

- (id)initWithContent:(id)content
            startTime:(NSTimeInterval)startTime
              endTime:(NSTimeInterval)endTime;

- (id)initWithContent:(id)content
            startTime:(NSTimeInterval)startTime
             duration:(NSTimeInterval)duration;

- (NSTimeInterval)endTime;
- (void)setEndTime:(NSTimeInterval)endTime;

- (NSComparisonResult)compare:(SKLine *)other;

@end
