//
//  SKNumeralTest.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-28.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKNumeralTest.h"

@implementation SKNumeralTest

- (void)testStringNumerals
{
    NSString *numeral = @"2";
    NSString *boolean = @"YES";
    NSString *bad = @"foobar";
    NSString *partial = @"2k";
    
    STAssertEquals([numeral integerValue], (NSInteger)2, @"Numeral should translate into a number");
    STAssertEquals([boolean boolValue], YES, @"Boolean ditto.");
    STAssertEquals([boolean integerValue], (NSInteger)0, @"Boolean should be distinctive.");
    STAssertEquals([bad integerValue], (NSInteger)0, @"Bad string should not translate");
    // STAssertEquals([partial integerValue], (NSInteger)0, @"Partials ditto");
}

- (void)testRegex
{
    NSString *valid = @"00:00:00,000 --> 23:45:67,890";
    NSString *invalid = @"00:00:00,000 --> 123:45:67,890";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9][0-9]\\:[0-9][0-9]\\:[0-9][0-9]\\,[0-9][0-9][0-9]\\ -->\\ [0-9][0-9]\\:[0-9][0-9]\\:[0-9][0-9]\\,[0-9][0-9][0-9]"
                                                                           options:0
                                                                             error:NULL];
    NSLog(@"%@", [regex matchesInString:valid
                                options:0
                                  range:NSMakeRange(0, [valid length])]);
    STAssertFalse([regex matchesInString:valid
                                 options:0
                                   range:NSMakeRange(0, [valid length])].count == 0, @"It should match");
    NSLog(@"%@", [regex matchesInString:invalid
                                options:0
                                  range:NSMakeRange(0, [valid length])]);
    STAssertTrue([regex matchesInString:invalid
                                options:0
                                  range:NSMakeRange(0, [valid length])].count == 0, @"It should not match");
}

@end
