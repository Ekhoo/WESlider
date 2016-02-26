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
static CGFloat const kMinimumOffsetToStick = 2.0f;

@interface WESlider ()

@property(nonatomic, strong, readwrite) NSArray *chunks;
@property(nonatomic, assign, readwrite) BOOL canStick;

@end

@implementation WESlider

- (instancetype)initWithWidth:(CGFloat)width {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, width, kSliderHeight)];
    
    if (self) {
        _canStick = NO;
        
        [self addTarget:self action:@selector(sliderValueDidChange) forControlEvents:UIControlEventValueChanged];
        [self addTarget:self action:@selector(sliderPressed) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchCancel];
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
        if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height == view.frame.size.width) {
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
        
        chunkView.backgroundColor = chunk.chunkColor;
        chunkView.tag = kChunkTag;
        
        [self insertSubview:chunkView belowSubview:referenceView];
    }
}

- (WEChunk *)getClosestChunk {
    WEChunk *closestChunk = nil;
    
    for (WEChunk *chunk in _chunks) {
        if (ABS(chunk.offset - self.value) <= kMinimumOffsetToStick) {
            closestChunk = chunk;
            
            break;
        }
    }
    
    return closestChunk;
}

- (void)sliderValueDidChange {
    if (!_canStick) {
        return;
    }
    
    WEChunk *closestChunk = [self getClosestChunk];
    
    if (closestChunk) {
        [self setValue:closestChunk.offset animated:YES];
    }
}

- (void)sliderPressed {
    _canStick = YES;
}

- (void)sliderReleased {
    _canStick = NO;
}

@end
