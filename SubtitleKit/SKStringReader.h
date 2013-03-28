//
//  SKStringReader.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-28.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKStringReader : NSObject

+ (SKStringReader *)readerWithString:(NSString *)source;

- (id)initWithString:(NSString *)reader;

- (NSString *)readLine;

- (NSUInteger)currentIndex;
- (void)setCurrentIndex:(NSUInteger)index;

- (BOOL)endOfString;

@end
