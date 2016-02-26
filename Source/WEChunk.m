//
//  WESliderItemSettings.m
//  WESlider
//
//  Created by Lucas Ortis on 26/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import "WEChunk.h"

@implementation WEChunk

- (instancetype)initWithDuration:(NSTimeInterval)duration {
    self = [super init];
    
    if (self) {
        _duration = duration;
    }
    
    return self;
}

@end
