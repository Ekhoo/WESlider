//
//  WESlider.h
//  WESlider
//
//  Created by Lucas Ortis on 26/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEChunk.h"

@interface WESlider : UISlider

@property(nonatomic, assign, readwrite) CGFloat minimumOffsetToStick;

- (instancetype)initWithWidth:(CGFloat)width;
- (void)setChunks:(NSArray *)chunks;

@end
