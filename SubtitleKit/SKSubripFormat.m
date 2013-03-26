//
//  SKSubripFormat.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKSubripFormat.h"

@implementation SKSubripFormat

+ (BOOL)lexicalAnalyseTimetag:(NSString *)line
                    startTime:(NSTimeInterval *)start
                      endTime:(NSTimeInterval *)end
                         rect:(NSRect *)rect
{
    
}

+ (SKSubtitleFile *)subtitleFileFromString:(NSString *)fileContent
                                    locale:(NSLocale *)locale
{
    NSMutableString *content = [fileContent mutableCopy]; // Char stream
    NSUInteger state = 0; // Refer to Subrip.md for info.
    
    while ([content length])
    {
        NSRange firstReturn = [content rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]];
        NSString *line = [[content substringToIndex:firstReturn.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [content deleteCharactersInRange:NSMakeRange(0, NSMaxRange(firstReturn))];
        
        NSMutableDictionary *stateInfo = [NSMutableDictionary dictionary]; // Not gonna use those pesky ivars.
        
        switch (state)
        {
            case 0:
            {
                // State 0: Hunt for the starting line number. What number is not important (to open partial files)
                // But the number must be solo on its line. And, there will be a look-back later.
                
                
            }
        }
    }
}

+ (NSString *)stringFromSubtitleFile:(SKSubtitleFile *)subtitleFile
                               track:(NSUInteger)track
{
    
}

@end
