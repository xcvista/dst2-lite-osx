//
//  SKSubripFormat.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKSubripFormat.h"

@implementation SKSubripFormat

+ (SKSubtitleFile *)subtitleFileFromString:(NSString *)fileContent
                                    locale:(NSLocale *)locale
{
    NSMutableString *content = [fileContent mutableCopy]; // Char stream
    NSUInteger state = 0; //0 = 
    
    while ([content length])
    {
        NSRange firstReturn = [content rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]];
        NSString *line = [[content substringToIndex:firstReturn.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [content deleteCharactersInRange:NSMakeRange(0, NSMaxRange(firstReturn))];
        
    }
}

+ (NSString *)stringFromSubtitleFile:(SKSubtitleFile *)subtitleFile
                               track:(NSUInteger)track
{
    
}

@end
