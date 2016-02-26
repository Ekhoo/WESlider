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

/*** Construct with offset ***/
+ (instancetype)chunkWithOffset:(CGFloat)offset chunkColor:(UIColor *)chunkColor;
+ (instancetype)chunkWithOffset:(CGFloat)offset;

/*** Construct with duration ***/
+ (instancetype)chunkWithDuration:(NSTimeInterval)duration chunkColor:(UIColor *)chunkColor;
+ (instancetype)chunkWithDuration:(NSTimeInterval)duration;

@end
