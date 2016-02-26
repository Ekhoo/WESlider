//
//  WESlider.m
//  WESlider
//
//  Created by Lucas Ortis on 26/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import "WESlider.h"

static CGFloat const kSliderHeight = 31.0f;
static NSInteger const kChunkTag = 42;
static CGFloat const kChunkWidth = 3.0;
static CGFloat const kChunkHeight = 2.0;

@interface WESlider ()

@property(nonatomic, strong, readwrite) NSArray *chunks;

@end

@implementation WESlider

- (instancetype)initWithWidth:(CGFloat)width {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, width, kSliderHeight)];
    
    if (self) {
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (![self hasChunks]) {
        [self displayChunks];
    }
}

- (void)setChunks:(NSArray *)chunks {
    _chunks = nil;
    
    for (UIView *view in self.subviews) {
        if (view.tag == kChunkTag) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat offset = ((WEChunk *)chunks.firstObject).duration;
    
    for (WEChunk *chunk in chunks) {
        chunk.offset = offset;
        
        offset += chunk.duration;
    }
    
    _chunks = chunks;
}

- (BOOL)hasChunks {
    BOOL hasChunks = NO;
    
    for (UIView *view in self.subviews) {
        if (view.tag == kChunkTag) {
            hasChunks = YES;
            break;
        }
    }
    
    return hasChunks;
}

- (UIView *)getReferenceView {
    UIView *referenceView = nil;
    
    for (UIView *view in self.subviews) {
        if (view.frame.size.height == kSliderHeight && view.frame.size.width == kSliderHeight) {
            referenceView = view;
            break;
        }
    }
    
    return referenceView;
}

- (void)displayChunks {
    CGFloat sliderWidth = CGRectGetWidth(self.frame);
    UIView *referenceView = [self getReferenceView];
    
    for (WEChunk *chunk in _chunks) {
        CGFloat chunkX = floor((chunk.offset - kChunkWidth / 2.0f) * sliderWidth / self.maximumValue);
        UIView *chunkView = [[UIView alloc] initWithFrame:CGRectMake(chunkX, floor(CGRectGetHeight(self.frame) / 2.0f - kChunkHeight / 2 + 1.0), kChunkWidth, kChunkHeight)];
        
        chunkView.backgroundColor = [UIColor blackColor];
        chunkView.tag = kChunkTag;
        
        [self insertSubview:chunkView belowSubview:referenceView];
    }
}

@end
