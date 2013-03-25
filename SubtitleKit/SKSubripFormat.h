//
//  SKSubripFormat.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSubtitleFile;

@interface SKSubripFormat : NSObject

+ (SKSubtitleFile *)subtitleFileFromString:(NSString *)fileContent
                                    locale:(NSLocale *)locale;
+ (NSString *)stringFromSubtitleFile:(SKSubtitleFile *)subtitleFile
                               track:(NSUInteger)track;

@end

@interface SKSubripFormat (SKAlternativeInputs)

+ (SKSubtitleFile *)subtitleFileFromFile:(NSString *)filename
                                encoding:(NSStringEncoding)encoding
                                  locale:(NSLocale *)locale;
+ (SKSubtitleFile *)subtitleFileFromURL:(NSURL *)url
                               encoding:(NSStringEncoding)encoding
                                 locale:(NSLocale *)locale;
+ (SKSubtitleFile *)subtitleFileFromData:(NSData *)data
                                encoding:(NSStringEncoding)encoding
                                  locale:(NSLocale *)locale;

+ (NSData *)dataFromSubtitleFile:(SKSubtitleFile *)subtitleFile
                      trackIndex:(NSUInteger)index
                        encoding:(NSStringEncoding)encoding;

@end