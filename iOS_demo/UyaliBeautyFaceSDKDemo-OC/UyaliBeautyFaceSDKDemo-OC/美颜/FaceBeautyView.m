//
//  FaceBeautyView.m
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import "FaceBeautyView.h"
#import "UyaliButton.h"

@interface FaceBeautyView ()

@property (nonatomic, strong)NSArray *beautyItems;

@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation FaceBeautyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDatas];
        [self setupView];
    }
    return self;
}

- (void)initDatas {
    _beautyItems = @[
        @{@"image": @"beauty_skin_white", @"name": @"美白"},
        @{@"image": @"beauty_skin_abrade", @"name": @"磨皮"},
        @{@"image": @"beauty_bright_eye", @"name": @"亮眼"},
        @{@"image": @"beauty_bright_teeth", @"name": @"白牙"}];
    
    _currentTag = 100;
}

#pragma mark - Setter & Getter
- (void)setCurrentTag:(NSInteger)currentTag {
    if (_currentTag != currentTag) {
        UyaliButton *newBtn = (UyaliButton *)[self viewWithTag:currentTag];
        UyaliButton *oldBtn = (UyaliButton *)[self viewWithTag:_currentTag];
        
        newBtn.selected = YES;
        oldBtn.selected = NO;
        
        if (currentTag == 100) {//美白 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 101) {//磨皮 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 102) {//亮眼 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 103) {//白牙 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        }
        
        _currentTag = currentTag;
    }
}

#pragma mark - UI
- (void)setupView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(16, 24, self.bounds.size.width-32, 30)];
    [self addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _slider.frame.origin.y)];
    [self addSubview:_valueLabel];
    _valueLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    _valueLabel.textColor = [UIColor whiteColor];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.text = @"0.0";
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.bounds.size.width, self.bounds.size.height-70)];
    [self addSubview:scroll];
    
    CGFloat buttonWidth = scroll.bounds.size.height;
    CGFloat buttonHeight = scroll.bounds.size.height;
    CGFloat buttonMargin = 16;
    
    scroll.contentSize = CGSizeMake(buttonMargin+(buttonWidth+buttonMargin)*_beautyItems.count, scroll.frame.size.height);
    
    for (NSInteger i = 0; i < _beautyItems.count; i++) {
        NSDictionary *item = _beautyItems[i];
        UyaliButton *button = [[UyaliButton alloc]initWithFrame:CGRectMake(buttonMargin+(buttonMargin+buttonWidth)*i, 0, buttonWidth, buttonHeight)];
        [scroll addSubview:button];
        [button setTitle:item[@"name"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:item[@"image"]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(beautyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        if (i == 0) {
            button.selected = YES;
            
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        }
        button.layer.cornerRadius = buttonWidth/2;
    }
}

#pragma mark - Action
- (void)beautyButtonAction:(UyaliButton *)button {
    self.currentTag = button.tag;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeBeautyType:)]) {
        [self.delegate changeBeautyType:button.tag];
    }
}

- (void)sliderValueChanged:(UISlider *)currentSlider {
    _valueLabel.text = [NSString stringWithFormat:@"%.1f",currentSlider.value];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getBeautyDeltaVale:type:)]) {
        [self.delegate getBeautyDeltaVale:_slider.value type:_currentTag];
    }
}

@end
