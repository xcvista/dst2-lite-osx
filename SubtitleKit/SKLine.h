//
//  SKLine.h
//  dst2-osx
//
//  Created by Maxthon Chan on 13-3-25.
//  Copyright (c) 2013年 Donghua University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SKTrack;

@interface SKLine : NSObject <NSCopying>

@property (weak) SKTrack *track;

@end
