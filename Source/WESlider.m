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
@property(nonatomic, assign, readwrite) BOOL canStick;

@end

@implementation WESlider

- (instancetype)initWithWidth:(CGFloat)width {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, width, kSliderHeight)];
    
    if (self) {
        _canStick = NO;
        _minimumOffsetToStick = 5.0f;
        
        [self addTarget:self action:@selector(sliderValueDidChange) forControlEvents:UIControlEventValueChanged];
        [self addTarget:self action:@selector(sliderPressed) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchCancel];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"You have to use the pre defined initializer.");
    
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_chunks && ![self hasChunks]) {
        [self displayChunks];
    }
}

- (void)setFrame:(CGRect)frame {
    [self removeChunks];
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kSliderHeight)];
}

- (void)removeChunks {
    for (UIView *view in self.subviews) {
        if (view.tag == kChunkTag) {
            [view removeFromSuperview];
        }
    }
}

- (void)setChunks:(NSArray *)chunks {
    _chunks = nil;
    
    [self removeChunks];
    
    CGFloat offset = 0.0f;
    
    for (WEChunk *chunk in chunks) {
        if (chunk.duration > 0) {
            offset += chunk.duration;
        } else {
            offset = chunk.offset;
        }
        
        chunk.offset = offset;
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
    UIView *referenceView = [self getReferenceView];
    CGFloat sliderWidth = CGRectGetWidth(self.frame) - CGRectGetWidth(referenceView.frame);
    
    for (WEChunk *chunk in _chunks) {
        
        if (chunk.offset >= self.maximumValue) {
            break;
        }
        
        CGFloat chunkX = floor(chunk.offset * sliderWidth / self.maximumValue) + CGRectGetWidth(referenceView.frame) / 2.0f - kChunkWidth / 2.0f;
        UIView *chunkView = [[UIView alloc] initWithFrame:CGRectMake(chunkX, floor(CGRectGetHeight(self.frame) / 2.0f - kChunkHeight / 2 + 1.0), kChunkWidth, kChunkHeight)];
        
        chunkView.backgroundColor = chunk.chunkColor;
        chunkView.tag = kChunkTag;
        
        [self insertSubview:chunkView belowSubview:referenceView];
    }
}

- (WEChunk *)getClosestChunk {
    WEChunk *closestChunk = nil;
    CGFloat currentValueXPos = self.value * CGRectGetWidth(self.frame) / self.maximumValue;
    
    for (WEChunk *chunk in _chunks) {
        CGFloat chunkValueXPos = chunk.offset * CGRectGetWidth(self.frame) / self.maximumValue;
        
        if (ABS(chunkValueXPos - currentValueXPos) <= _minimumOffsetToStick) {
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

- (void)setMaximumValue:(float)maximumValue {
    [super setMaximumValue:maximumValue];
    
    [self setFrame:self.frame];
}

@end
