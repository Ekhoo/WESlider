//
//  ViewController.m
//  WESlider
//
//  Created by Lucas Ortis on 25/02/2016.
//  Copyright © 2016 Lucas Ortis. All rights reserved.
//

#import "DemoViewController.h"
#import "WESlider.h"

@interface DemoViewController ()

@property(nonatomic, strong, readonly) WESlider *slider;

@end

@implementation DemoViewController

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _slider = [[WESlider alloc] initWithWidth:CGRectGetWidth(self.view.frame)];
    _slider.maximumValue = 100.0f;
    _slider.minimumValue = 0.0f;
    _slider.value = 0.0f;
    _slider.minimumTrackTintColor = [UIColor colorWithRed:252.0f / 255.0f green:204.0f / 255.0f blue:47.0f / 255.0f alpha:1.0f];
    _slider.center = self.view.center;
    
    [_slider setChunks:@[
                          [WEChunk chunkWithDuration:25.0f],
                          [WEChunk chunkWithDuration:25.0f],
                          [WEChunk chunkWithDuration:25.0f]
                         ]];
    
    [self.view addSubview:_slider];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
