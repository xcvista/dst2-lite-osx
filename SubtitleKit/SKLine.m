//
//  SKLine.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKLine.h"

@interface SKLine ()

@property NSMutableDictionary *style;

@end

@implementation SKLine

- (id)initWithContent:(id)content startTime:(NSTimeInterval)startTime duration:(NSTimeInterval)duration
{
    if (self = [super init])
    {
        self.content = content;
        self.startTime = startTime;
        self.duration = duration;
        self.style = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithContent:(id)content startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime
{
    return [self initWithContent:content startTime:startTime duration:endTime - startTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SKLine *newLine = [[[self class] allocWithZone:zone] initWithContent:self.content
                                                               startTime:self.startTime
                                                                duration:self.duration];
    return newLine;
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

- (void)setStyle:(id)style forKey:(NSString *)key
{
    [self willChangeValueForKey:@"style"];
    self.style[key] = style;
    [self didChangeValueForKey:@"style"];
}

- (id)styleForKey:(NSString *)key
{
    return self.style[key];
}

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key
{
    [self setStyle:object forKey:key];
}

- (id)objectForKeyedSubscript:(NSString *)key
{
    return [self styleForKey:key];
}

- (NSDictionary *)allStyles
{
    return [self.style copy];
}

@end

NSString *const SKFontStyleKey              = @"font";
NSString *const SKFontFamilyStyleKey        = @"font-family";
NSString *const SKFontSizeStyleKey          = @"font-size";
NSString *const SKFontWeightStyleKey        = @"font-weight";
NSString *const SKColorStyleKey             = @"color";
NSString *const SKOpacityStyleKey           = @"opacity";
NSString *const SKFontStyleStyleKey         = @"font-style";
NSString *const SKTextDecorationStyleKey    = @"text-decoration";
NSString *const SKTextAlignmentStyleKey     = @"text-align";
NSString *const SKStrokeColorStyleKey       = @"stroke-color";
NSString *const SKStrokeOpacityStyleKey     = @"stroke-opacity";
NSString *const SKStrokeWidthStyleKey       = @"stroke-width";
NSString *const SKStrokeStyleKey            = @"stroke-style";
NSString *const SKBorderRectStyleKey        = @"border-rect";
NSString *const SKBorderOriginStyleKey      = @"border-origin";
NSString *const SKBorderSizeStyleKey        = @"border-size";
NSString *const SKBorderStyleKey            = @"border-style";
NSString *const SKBorderShapeKey            = @"border-shape";
NSString *const SKBackgroundColorStyleKey   = @"background-color";
NSString *const SKBackgroundOpacityStyleKey = @"background-opacity";
NSString *const SKMarginStyleKey            = @"margin";
NSString *const SKVerticalAlignStyleKey     = @"vertical-align";


