//
//  FDFrequencySpectrumIndicator.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/26.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "FDFrequencySpectrumIndicator.h"
#import <QuartzCore/QuartzCore.h>
#import "FDRect180UpDownAni.h"
#import "FDRect360UpDownAni.h"

@implementation FDFrequencySpectrumIndicatorConfig
@end

@interface FDFrequencySpectrumIndicator ()
@property(strong, nonatomic)NSNumber* frequencyNum;
@property(strong, nonatomic)UIColor* tintColor;
@property(assign, nonatomic)CGFloat frequencyWidth;
@property(assign, nonatomic)CGFloat frequencyMargin;
@property(assign, nonatomic)FDFrequencySpectrumIndicatorType frequencyType;
@property(strong, nonatomic)CADisplayLink* link;
@property(strong, nonatomic)NSMutableArray<NSNumber*>* frequencyDatas;
@property(strong, nonatomic)CALayer* animationLayer;
@end

@implementation FDFrequencySpectrumIndicator

- (instancetype)initWithConfig:(FDFrequencySpectrumIndicatorConfig*)config {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
        
        _frequencyNum = config.frequencyNum?config.frequencyNum:@8;
        _tintColor = config.tintColor?config.tintColor:[UIColor colorWithRed:52.f/255 green:232.f/255 blue:158.f/255 alpha:1.0f];
        _frequencyMargin = config.frequencyMargin?config.frequencyMargin:4.0f;
        _frequencyWidth = config.frequencyWidth?config.frequencyWidth:6.0f;
        _frequencyType = config.frequencyType;
        
        _frequencyDatas = [NSMutableArray new];
        
        switch (_frequencyType) {
            case FDRect180UpDownType:
                _animationLayer = [[FDRect180UpDownAni alloc]initWithWidth:_frequencyWidth margin:_frequencyMargin num:_frequencyNum.unsignedIntegerValue];
                break;
            case FDRect360UpDownType:
                _animationLayer = [[FDRect360UpDownAni alloc]initWithColor:_tintColor.CGColor width:_frequencyWidth num:_frequencyNum.unsignedIntegerValue];
            default:
                break;
        }

        [self.layer addSublayer:_animationLayer];
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (instancetype)init {
    FDFrequencySpectrumIndicatorConfig* config;
    config = [FDFrequencySpectrumIndicatorConfig new];
    if (self = [self initWithConfig:config]) {
    }
    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    _animationLayer.frame = self.bounds;
}

- (void)startTest {
    //生成音频谱Demo数据
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.frequencyDatas removeAllObjects];
        for (int index = 0; index < self.frequencyNum.intValue; index ++) {
            srand((unsigned)time(NULL));
            [self.frequencyDatas addObject:@((CGFloat)drand48())];
        }
    }];
}

- (void)update {
    [((FDRect180UpDownAni*)self.animationLayer)updateData:self.frequencyDatas];
}
@end
