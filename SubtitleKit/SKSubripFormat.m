//
//  SKSubripFormat.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKSubripFormat.h"
#import "SKSubtitleFile.h"
#import "SKTrack.h"
#import "SKLine.h"
#import "SKStringReader.h"

#define PtrAssign(ptr, value) \
do {\
typeof(ptr) _ptr = ptr;\
if (_ptr)\
*_ptr = value;\
} while(0)

@implementation SKSubripFormat

#if SK_SRT_MODE == SK_SRT_PARSER

// TODO: Finish this more structured parser, though it is actually a hell lot
//       more complicated and less fast than the ad-hoc one. It is more powerful
//       though.

+ (BOOL)lexicalAnalyseNumber:(NSString *)line
                     integer:(NSInteger *)number
                      digits:(NSUInteger)digits
              analysedDigits:(NSUInteger *)analysedDigits
                   deadChars:(NSUInteger *)deadChars
{
    // Number = [+-][1-9][0-9]*
    NSUInteger value = 0;
    BOOL sign = NO; // NO = +, YES = -
    NSUInteger state = 0;
    NSUInteger i = 0;
    NSUInteger dead = 0;
    
    if (!digits)
        digits = NSIntegerMax;
    
    for (dead = 0; dead < MIN([line length], digits); dead++)
    {
        unichar ch = [line characterAtIndex:dead];
        if ((ch >= '0' && ch <= '9') || ch == '+' || ch == '-')
            break;
    }
    
    for (i = dead; i < MIN([line length], digits); i++)
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
                    PtrAssign(analysedDigits, i - dead);
                    PtrAssign(deadChars, dead);
                    return NO;
                }
            }
            default:
            {
                PtrAssign(number, value);
                PtrAssign(analysedDigits, i - dead);
                PtrAssign(deadChars, dead);
                return NO;
            }
        }
    }
    PtrAssign(number, value);
    PtrAssign(analysedDigits, i - dead);
    PtrAssign(deadChars, dead);
    return YES;
}

+ (BOOL)lexicalAnalyseTime:(NSString *)line
                      time:(NSTimeInterval *)time
{
    
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
                //          But the number must be solo on its line. And, there will be a look-back later (St. 1).
                
                NSUInteger numberOfChars;
                
                if ([self lexicalAnalyseNumber:line
                                       integer:NULL
                                        digits:0
                                analysedDigits:&numberOfChars
                                     deadChars:NULL] && numberOfChars == [line length])
                {
                    state = 1; // Find a solo number line
                }
                break;
            }
            case 1:
            {
                NSTimeInterval start = 0, end = 0;
                NSRect displayRect = NSMakeRect(-1, -1, -1, -1);
                
                if ([self lexicalAnalyseTimetag:line
                                      startTime:&start
                                        endTime:&end
                                           rect:&displayRect])
                {
                    
                }
            }
        }
    }
}

+ (NSString *)stringFromSubtitleFile:(SKSubtitleFile *)subtitleFile
                               track:(NSUInteger)track
{
    
}

#elif SK_SRT_MODE == SK_SRT_ADHOC

+ (SKSubtitleFile *)subtitleFileFromString:(NSString *)fileContent locale:(NSLocale *)locale
{
    /*
     The following is the original Visual Basic implementation:
     
     Public Shared Function LoadSRT(ByVal stream As Stream) As LrcFile
        Dim lf As New LrcFile
        Dim sr As New StreamReader(stream)
        Dim currLine As Line
        Dim isBody As Boolean = False
        Dim phase As Integer = 0
        Dim str As String
     
        Do Until sr.EndOfStream
            str = Trim(sr.ReadLine)
            If Trim(CStr(CInt(Val(str)))) = str Then
                'New line
                If isBody And Not IsNothing(currLine) Then
                    currLine.Content = currLine.Content.Trim
                    lf.Add(currLine)
                End If
                isBody = True
                phase = 1
            End If
            Select Case phase
                Case 1
                    'Time tag
                    If str Like "??:??:??,??? --> ??:??:??,???" Then
                        Dim tg1 As New TimeSpan(0, CInt(Mid(str, 1, 2)), _
                                                   CInt(Mid(str, 4, 2)), _
                                                   CInt(Mid(str, 7, 2)), _
                                                   CInt(Mid(str, 10, 3)))
                        Dim tg2 As New TimeSpan(0, CInt(Mid(str, 18, 2)), _
                                                   CInt(Mid(str, 21, 2)), _
                                                   CInt(Mid(str, 24, 2)), _
                                                   CInt(Mid(str, 27, 3)))
                        currLine = New Line(tg1, tg2)
                        phase = 2
                    End If
                Case 2
                    'Content
                    currLine.Content += str.Trim + vbCrLf
            End Select
        Loop
        If Not IsNothing(currLine) Then
            currLine.Content = currLine.Content.Trim
            lf.Add(currLine)
        End If
        sr.Close()
        lf.Sort()
        Return lf
     End Function
     
     LrcFile class is replaced with SKTrack. Line is SKLine. TimeSpan is not a
     class, thus ad-hoc'ly reimplemented as NSTimeInterval. StreamReader is 
     ad-hoc'ly implemented using NSMutableString.
     
     It does not read the display location information yet.
     */
    SKTrack *track = [[SKTrack alloc] initWithLocale:locale];
    SKStringReader *stringReader = [SKStringReader readerWithString:fileContent];
    SKLine *currentLine = nil;
    BOOL isBody = NO;
    NSUInteger stage = 0;
    
    while (![stringReader endOfString])
    {
        NSString *stringBuffer = [[stringReader readLine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([[NSString stringWithFormat:@"%ld", [stringBuffer integerValue]] isEqualToString:stringBuffer])
        {
            // New line.
            if (isBody && currentLine)
            {
                [currentLine setStringValue:[[currentLine stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                [track addLine:currentLine];
                currentLine = nil;
            }
            isBody = YES;
            stage = 1;
            continue;
        }
        
        switch (stage)
        {
            case 1:
            {
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9][0-9]\\:[0-9][0-9]\\:[0-9][0-9]\\,[0-9][0-9][0-9]\\ -->\\ [0-9][0-9]\\:[0-9][0-9]\\:[0-9][0-9]\\,[0-9][0-9][0-9]"
                                                                                       options:0
                                                                                         error:NULL];
                // I am using regex here.
            }
            default:
                break;
        }
    }
}

#else

#error Please select a corrent SRT mode in SKSubripFormat.h

#endif

@end
