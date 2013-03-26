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

- (NSDictionary *)allStyles;
- (id)styleForKey:(NSString *)key;
- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setStyle:(id)style forKey:(NSString *)key;
- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;

- (NSComparisonResult)compare:(SKLine *)other;

@end

// CSS-based styling.

extern NSString *const SKFontStyleKey;              // font (Not saved)
extern NSString *const SKFontFamilyStyleKey;        // > font-family
extern NSString *const SKFontSizeStyleKey;          // > font-size
extern NSString *const SKFontWeightStyleKey;        // > font-weight
extern NSString *const SKColorStyleKey;             // color
extern NSString *const SKOpacityStyleKey;           // > opacity
extern NSString *const SKFontStyleStyleKey;         // font-style
extern NSString *const SKTextDecorationStyleKey;    // text-decoration
extern NSString *const SKTextAlignmentStyleKey;     // text-align
extern NSString *const SKStrokeColorStyleKey;       // stroke-color
extern NSString *const SKStrokeOpacityStyleKey;     // > stroke-opacity
extern NSString *const SKStrokeWidthStyleKey;       // stroke-width
extern NSString *const SKStrokeStyleKey;            // stroke-style
extern NSString *const SKBorderRectStyleKey;        // border-rect (Not saved)
extern NSString *const SKBorderOriginStyleKey;      // > border-origin
extern NSString *const SKBorderSizeStyleKey;        // > border-size
extern NSString *const SKBorderStyleKey;            // border-style
extern NSString *const SKBorderShapeKey;            // border-shape
extern NSString *const SKBackgroundColorStyleKey;   // background-color
extern NSString *const SKBackgroundOpacityStyleKey; // background-opacity
extern NSString *const SKMarginStyleKey;            // margin (Used to determine rounded corners' radius)
extern NSString *const SKVerticalAlignStyleKey;     // vertical-align

typedef NS_ENUM(NSUInteger, SKFontStyle)            // font-style
{
    SKFontStyleNormal = 0,
    SKFontStyleItalic,
    SKFontStyleOblique,
};

typedef NS_ENUM(NSUInteger, SKTextDecoration)       // text-decoration
{
    SKTextDecorationNone            = 0,
    SKTextDecorationUnderline       = 1,
    SKTextDecorationStrikethrough   = 2,
    SKTextDecorationOverline        = 4,
};

typedef NS_ENUM(NSUInteger, SKBorderStyle)          // stroke-style, border-style
{
    SKBorderStyleNone = 0,
    SKBorderStyleDotted,
    SKBorderStyleDashed,
    SKBorderStyleSolid,
    SKBorderStyleDouble,
};

typedef NS_ENUM(NSUInteger, SKBorderShape)          // border-shape
{
    SKBorderShapeNone = 0,
    SKBorderShapeRectangle,
    SKBorderShapeRounded,
    SKBorderShapeEllipse,
};

typedef NS_ENUM(NSUInteger, SKVerticalAlignment)    // vertical-align
{
    SKVerticalAlignmentBaseline = 0,
    SKVerticalAlignmentSubscript,
    SKVerticalAlignmentSuperscript,
    SKVerticalAlignmentTop,
    SKVerticalAlignmentTextTop,
    SKVerticalAlignmentMiddle,
    SKVerticalAlignmentBottom,
    SKVerticalAlignmentTextBottom,
};

@interface SKLine (SKStyle)

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

@interface SKLine (SKStringContentObject)

- (NSString *)stringValue;
- (void)setStringValue:(NSString *)stringValue;

- (NSAttributedString *)attributedStringValue;
- (void)setAttributedStringValue:(NSAttributedString *)attributedString;

@end

extern NSString *const SKSizeRectStyleKey;  // rect-size (Not saved)
extern NSString *const SKWidthStyleKey;     // > width
extern NSString *const SKHeightStyleKey;    // > height

@interface SKLine (SKImageStyle)

- (NSSize)rectSize;
- (void)setRectSize:(NSSize)rectSize;

@end

@interface SKLine (SKImageLine)

- (NSImage *)imageValue;
- (void)setImageValue:(NSImage *)imageValue;

@end
