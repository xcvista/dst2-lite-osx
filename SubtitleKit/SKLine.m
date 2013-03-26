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
NSString *const SKBorderShapeStyleKey       = @"border-shape";
NSString *const SKBackgroundColorStyleKey   = @"background-color";
NSString *const SKBackgroundOpacityStyleKey = @"background-opacity";
NSString *const SKMarginStyleKey            = @"margin";
NSString *const SKVerticalAlignStyleKey     = @"vertical-align";

@implementation SKLine (SKStyle)

- (NSFont *)font
{
    return self[SKFontStyleKey];
}

- (void)setFont:(NSFont *)font
{
    self[SKFontStyleKey] = font;
}

- (NSColor *)color
{
    return self[SKColorStyleKey];
}

- (void)setColor:(NSColor *)color
{
    self[SKColorStyleKey] = color;
}

- (SKFontStyle)fontStyle
{
    return [self[SKFontStyleStyleKey] unsignedIntegerValue];
}

- (void)setFontStyle:(SKFontStyle)fontStyle
{
    self[SKFontStyleStyleKey] = @(fontStyle);
}

- (SKTextDecoration)textDecoration
{
    return [self[SKTextDecorationStyleKey] unsignedIntegerValue];
}

- (void)setTextDecoration:(SKTextDecoration)textDecoration
{
    self[SKTextDecorationStyleKey] = @(textDecoration);
}

- (NSTextAlignment)textAlignment
{
    return [self[SKTextAlignmentStyleKey] unsignedIntegerValue];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    self[SKTextAlignmentStyleKey] = @(textAlignment);
}

- (NSColor *)strokeColor
{
    return self[SKStrokeColorStyleKey];
}

- (void)setStrokeColor:(NSColor *)color
{
    self[SKStrokeColorStyleKey] = color;
}

- (CGFloat)strokeWidth
{
    return [self[SKStrokeWidthStyleKey] doubleValue];
}

- (void)setStrokeWidth:(CGFloat)borderWidth
{
    self[SKStrokeWidthStyleKey] = @(borderWidth);
}

- (SKBorderStyle)strokeStyle
{
    return [self[SKStrokeStyleKey] unsignedIntegerValue];
}

- (void)setStrokeStyle:(SKBorderStyle)strokeStyle
{
    self[SKStrokeStyleKey] = @(strokeStyle);
}

- (NSRect)borderRect
{
    NSValue *rectValue = self[SKBorderRectStyleKey];
    if (rectValue)
        return [rectValue rectValue];
    else
        return NSMakeRect(-1, -1, -1, -1);
}

- (void)setBorderRect:(NSRect)borderRect
{
    self[SKBorderRectStyleKey] = [NSValue valueWithRect:borderRect];
}

- (SKBorderShape)borderShape
{
    return [self[SKBorderShapeStyleKey] unsignedIntegerValue];
}

- (void)setBorderShape:(SKBorderShape)borderShape
{
    self[SKBorderShapeStyleKey] = @(borderShape);
}

- (SKBorderStyle)borderStyle
{
    return [self[SKBorderStyleKey] unsignedIntegerValue];
}

- (void)setBorderStyle:(SKBorderStyle)borderStyle
{
    self[SKBorderStyleKey] = @(borderStyle);
}

- (NSColor *)backgroundColor
{
    return self[SKBackgroundColorStyleKey];
}

- (void)setBackgroundColor:(NSColor *)color
{
    self[SKBackgroundColorStyleKey] = color;
}

- (CGFloat)margin
{
    return [self[SKMarginStyleKey] doubleValue];
}

- (void)setMargin:(CGFloat)margin
{
    self[SKMarginStyleKey] = @(margin);
}

@end

@implementation SKLine (SKStringContentObject)

- (NSString *)stringValue
{
    if ([self.content isKindOfClass:[NSAttributedString class]])
    {
        NSAttributedString *content = self.content;
        return [content string];
    }
    else if ([self.content isKindOfClass:[NSString class]])
    {
        return [self.content copy];
    }
    else
        return nil;
}

- (void)setStringValue:(NSString *)stringValue
{
    if ([stringValue isKindOfClass:[NSAttributedString class]])
    {
        NSAttributedString *attributedString = (NSAttributedString *)stringValue;
        self.content = [attributedString string];
    }
    else if ([stringValue isKindOfClass:[NSString class]])
    {
        self.content = [stringValue copy];
    }
}

- (NSAttributedString *)attributedStringValue
{
    if ([self.content isKindOfClass:[NSAttributedString class]])
    {
        return [self.content copy];
    }
    else if ([self.content isKindOfClass:[NSString class]])
    {
        return [[NSAttributedString alloc] initWithString:self.content];
    }
    else
        return nil;
}

- (void)setAttributedStringValue:(NSAttributedString *)attributedString
{
    self.content = attributedString;
}

@end

NSString *const SKSizeRectStyleKey = @"rect-size";
NSString *const SKWidthStyleKey = @"width";
NSString *const SKHeightStyleKey = @"height";

@implementation SKLine (SKImageStyle)

- (NSSize)rectSize
{
    NSValue *rectSize = self[SKSizeRectStyleKey];
    if (rectSize)
        return [rectSize sizeValue];
    else
        return NSMakeSize(-1, -1);
}

- (void)setRectSize:(NSSize)rectSize
{
    self[SKSizeRectStyleKey] = [NSValue valueWithSize:rectSize];
}

@end

@implementation SKLine (SKImageContentObject)

- (NSImage *)imageValue
{
    if ([self.content isKindOfClass:[NSImage class]])
        return self.content;
    else
        return nil;
}

- (void)setImageValue:(NSImage *)imageValue
{
    self.content = imageValue;
}

@end
