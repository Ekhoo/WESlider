//
//  WESliderItemSettings.m
//  WESlider
//
//  Created by Lucas Ortis on 26/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import "WEChunk.h"

@implementation WEChunk

- (instancetype)initWithDuration:(NSTimeInterval)duration chunkColor:(UIColor *)chunkColor {
    self = [super init];
    
    if (self) {
        _duration = duration;
        _chunkColor = chunkColor;
    }
    
    return self;
}

+ (instancetype)chunkWithDuration:(NSTimeInterval)duration chunkColor:(UIColor *)chunkColor {
    return [[WEChunk alloc] initWithDuration:duration chunkColor:chunkColor];
}

+ (instancetype)chunkWithDuration:(NSTimeInterval)duration {
    return [[WEChunk alloc] initWithDuration:duration chunkColor:[UIColor darkGrayColor]];
}

@end
