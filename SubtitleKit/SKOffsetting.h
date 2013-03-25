//
//  SKOffsetting.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <SubtitleKit/SKSubtitleFile.h>

extern NSString *const SKOffsetMetadataKey;

@interface SKSubtitleFile (SKOffsetting)

- (void)applyOffset;
- (void)setOffset:(NSTimeInterval)offset;
- (NSTimeInterval)offset;

@end
