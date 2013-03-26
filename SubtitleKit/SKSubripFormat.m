//
//  SKSubripFormat.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKSubripFormat.h"

#define PtrAssign(ptr, value) \
do {\
typeof(ptr) _ptr = ptr;\
if (_ptr)\
*_ptr = value;\
} while(0)

@implementation SKSubripFormat

+ (BOOL)lexicalAnalyseNumber:(NSString *)line
                     integer:(NSInteger *)number
                      digits:(NSUInteger)digits
              analysedDigits:(NSUInteger *)analysedDigits
{
    // Number = [+-][1-9][0-9]*
    NSUInteger value = 0;
    BOOL sign = NO; // NO = +, YES = -
    NSUInteger state = 0;
    NSUInteger i = 0;
    
    for (i = 0; i < MIN([line length], digits); i++)
    {
        unichar ch = [line characterAtIndex:i];
        
        switch (state)
        {
            case 0: // sign or digit
            {
                if (ch == '+')
                {
                    sign = NO;
                    state = 1;
                    break;
                }
                else if (ch == '-')
                {
                    sign = YES;
                    state = 1;
                    break;
                }
            }
            case 1: // digit
            {
                if (ch >= '0' && ch <= 9)
                {
                    value *= 10;
                    value += ch - '0';
                }
                else
                {
                    PtrAssign(number, value);
                    PtrAssign(analysedDigits, i);
                    return NO;
                }
            }
            default:
            {
                PtrAssign(number, value);
                PtrAssign(analysedDigits, i);
                return NO;
            }
        }
    }
    PtrAssign(number, value);
    PtrAssign(analysedDigits, i);
    return YES;
}

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
    NSMutableDictionary *stateInfo = [NSMutableDictionary dictionary]; // Not gonna use those pesky ivars.
    
    while ([content length])
    {
        NSRange firstReturn = [content rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]];
        NSString *line = [[content substringToIndex:firstReturn.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [content deleteCharactersInRange:NSMakeRange(0, NSMaxRange(firstReturn))];
        
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
