![WESlider](https://github.com/Ekhoo/WESlider/blob/master/Source/Asset/weslider.png)

[![Version](https://img.shields.io/cocoapods/v/WESlider.svg?style=flat)](http://cocoapods.org/pods/WESlider)
[![License](https://img.shields.io/cocoapods/l/WESlider.svg?style=flat)](http://cocoapods.org/pods/WESlider)
[![Platform](https://img.shields.io/cocoapods/p/WESlider.svg?style=flat)](http://cocoapods.org/pods/WESlider)
![](https://img.shields.io/badge/Supported-iOS7-4BC51D.svg?style=flat-square)

Simple and light weight slider with chapter management

# Demo
![WESlider](https://github.com/Ekhoo/WESlider/blob/master/Source/Asset/slider.gif)

# Installation
## CocoaPods
WESlider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WESlider", '~> 0.0.5'
```

# Usage
```objective-c
- (void)loadView {
    [super loadView];
    
    WESlider *slider = [[WESlider alloc] initWithWidth:CGRectGetWidth(self.view.frame)];
    slider.maximumValue = 100.0f;
    slider.minimumValue = 0.0f;
    
    [_slider setChunks:@[
                          [WEChunk chunkWithDuration:25.0f],
                          [WEChunk chunkWithOffset:50],
                          [WEChunk chunkWithDuration:25.0f]
                         ]];
    
    [self.view addSubview:slider];
}
```

# Author
Lucas Ortis:
- me@lucas-ortis.com
- [@LucasEkhoo](https://twitter.com/LucasEkhoo)
- [Linkedin](https://fr.linkedin.com/in/lucasortis)

# License

WESlider is available under the MIT license. See the LICENSE file for more info.
