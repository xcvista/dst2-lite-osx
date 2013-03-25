//
//  SKTrack.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SKSubtitleFile, SKLine;

@interface SKTrack : NSObject <NSCopying>

@property NSLocale *locale;
@property (weak) SKSubtitleFile *subtitleFile;

- (id)initWithLocale:(NSLocale *)locale;
- (instancetype)deepCopy;

- (NSArray *)allLines;
- (SKLine *)lineAtIndex:(NSUInteger)index;
- (SKLine *)lineAtTime:(NSTimeInterval)time;
- (NSArray *)linesAtTime:(NSTimeInterval)time;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)addLine:(SKLine *)line;
- (void)setLine:(SKLine *)line atIndex:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;
- (void)sortLines;

@end
