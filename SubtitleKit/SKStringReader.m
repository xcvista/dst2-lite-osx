//
//  SKStringReader.m
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-28.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import "SKStringReader.h"

@interface SKStringReader ()

@property NSString *data;
@property NSUInteger index;

@end

@implementation SKStringReader

+ (SKStringReader *)readerWithString:(NSString *)source
{
    return [[self alloc] initWithString:source];
}

- (id)initWithString:(NSString *)reader
{
    if (self = [super init])
    {
        self.data = reader;
        self.index = 0;
    }
    return self;
}

- (NSString *)readLine
{
    if ([self endOfString])
        return nil;
    
    NSRange range = [self.data rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]
                                               options:0
                                                 range:NSMakeRange(self.index, [self.data length] - self.index)];
    NSUInteger lastIndex = NSMaxRange(range);
    
    if (range.location == NSNotFound)
    {
        NSRange returnRange = NSMakeRange(self.index, lastIndex - self.index);
        self.index = [self.data length];
        return [self.data substringFromIndex:returnRange.location];
    }
    else
    {
        for (lastIndex = NSMaxRange(range);
             [[NSCharacterSet newlineCharacterSet] characterIsMember:[self.data characterAtIndex:lastIndex]];
             lastIndex++);
        NSRange returnRange = NSMakeRange(self.index, lastIndex - self.index);
        self.index = lastIndex;
        return [self.data substringWithRange:returnRange];
    }
    
}

- (NSUInteger)currentIndex
{
    return self.index;
}

- (void)setCurrentIndex:(NSUInteger)index
{
    NSParameterAssert(index < [self.data length]);
    self.index = index;
}

- (BOOL)endOfString
{
    return self.index >= [self.data length];
}

@end
