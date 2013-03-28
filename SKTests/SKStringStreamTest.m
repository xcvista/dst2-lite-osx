//
//  SKStringStreamTest.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-28.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKStringStreamTest.h"
#import "SKStringReader.h"

@implementation SKStringStreamTest

- (void)testStringStreamUNIX
{
    NSString *longString = @"hello\nworld\nfoo\nbar\nbat\nqux";
    NSUInteger iterations = 0;
    NSArray *strings = @[@"hello\n", @"world\n", @"foo\n", @"bar\n", @"bat\n", @"qux"];
    SKStringReader *reader = [SKStringReader readerWithString:longString];
    
    for (NSString *item in strings)
    {
        NSString *load = [reader readLine];
        STAssertEqualObjects(item, load, @"Item %lu should be %@ instead of %@", iterations, item, load);
    }
    STAssertNil([reader readLine], @"Nil should be returned for dead reads");
    
#if !defined(NS_BLOCK_ASSERTS)
    STAssertThrows([reader setCurrentIndex:512], @"It should be overflow-proof.");
#endif
}

- (void)testStringStreamWindows
{
    NSString *longString = @"hello\r\nworld\r\nfoo\r\nbar\r\nbat\r\nqux";
    NSUInteger iterations = 0;
    NSArray *strings = @[@"hello\r\n", @"world\r\n", @"foo\r\n", @"bar\r\n", @"bat\r\n", @"qux"];
    SKStringReader *reader = [SKStringReader readerWithString:longString];
    
    for (NSString *item in strings)
    {
        NSString *load = [reader readLine];
        STAssertEqualObjects(item, load, @"Item %lu should be %@ instead of %@", iterations, item, load);
    }
    STAssertNil([reader readLine], @"Nil should be returned for dead reads");
    
#if !defined(NS_BLOCK_ASSERTS)
    STAssertThrows([reader setCurrentIndex:512], @"It should be overflow-proof.");
#endif
}

@end
