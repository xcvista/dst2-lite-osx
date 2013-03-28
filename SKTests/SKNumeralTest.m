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

@end
