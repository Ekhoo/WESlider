//
//  WESliderItemSettings.h
//  WESlider
//
//  Created by Lucas Ortis on 26/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEChunk : NSObject

@property(nonatomic, assign, readonly) NSTimeInterval duration;
@property(nonatomic, assign, readwrite) CGFloat offset;
@property(nonatomic, readwrite, readwrite) UIColor *chunkColor;

- (instancetype)initWithDuration:(NSTimeInterval)duration chunkColor:(UIColor *)chunkColor;

@end
