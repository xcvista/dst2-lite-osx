//
//  SKTrack.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SubtitleKit/SKLine.h>

@class SKSubtitleFile, SKLine;

@interface SKTrack : NSObject <NSCopying>

@property NSLocale *locale;
@property (weak) SKSubtitleFile *subtitleFile;
@property NSMutableDictionary *style;

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

@interface SKTrack (SKStyle)

- (NSFont *)font;
- (void)setFont:(NSFont *)font;

- (NSColor *)color;
- (void)setColor:(NSColor *)color;

- (SKFontStyle)fontStyle;
- (void)setFontStyle:(SKFontStyle)fontStyle;

- (SKTextDecoration)textDecoration;
- (void)setTextDecoration:(SKTextDecoration)textDecoration;

- (NSTextAlignment)textAlignment;
- (void)setTextAlignment:(NSTextAlignment)textAlignment;

- (NSColor *)strokeColor;
- (void)setStrokeColor:(NSColor *)color;

- (CGFloat)strokeWidth;
- (void)setStrokeWidth:(CGFloat)borderWidth;

- (SKBorderStyle)strokeStyle;
- (void)setStrokeStyle:(SKBorderStyle)strokeStyle;

- (NSRect)borderRect;
- (void)setBorderRect:(NSRect)borderRect;

- (SKBorderStyle)borderStyle;
- (void)setBorderStyle:(SKBorderStyle)borderStyle;

- (SKBorderShape)borderShape;
- (void)setBorderShape:(SKBorderShape)borderShape;

- (NSColor *)backgroundColor;
- (void)setBackgroundColor:(NSColor *)color;

- (CGFloat)margin;
- (void)setMargin:(CGFloat)margin;

@end
