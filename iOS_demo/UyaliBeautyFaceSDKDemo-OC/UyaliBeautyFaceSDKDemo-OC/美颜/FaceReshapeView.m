//
//  FaceReshapeView.m
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import "FaceReshapeView.h"
#import "UyaliButton.h"

@interface FaceReshapeView ()

@property (nonatomic, strong)NSArray *beautyItems;

@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation FaceReshapeView

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
        @{@"image": @"beauty_shape_head_reduce", @"name": @"小头"},
        @{@"image": @"beauty_shape_face_thin", @"name": @"瘦脸"},
        @{@"image": @"beauty_shape_face_narrow", @"name": @"窄脸"},
        @{@"image": @"beauty_shape_face_v", @"name": @"V脸"},
        @{@"image": @"beauty_shape_face_small", @"name": @"小脸"},
        @{@"image": @"beauty_shape_chin", @"name": @"下巴"},
        @{@"image": @"beauty_shape_forehead", @"name": @"额头"},
        @{@"image": @"beauty_shape_cheekbone", @"name": @"颧骨"},
        @{@"image": @"beauty_shape_eye_big", @"name": @"大眼"},
        @{@"image": @"beauty_shape_eye_distance", @"name": @"眼距"},
        @{@"image": @"beauty_shape_eye_corner", @"name": @"开眼角"},
        @{@"image": @"beauty_shape_eyelid_down", @"name": @"眼睑下至"},
        @{@"image": @"beauty_shape_nose_thin", @"name": @"瘦鼻"},
        @{@"image": @"beauty_shape_nose_wing", @"name": @"鼻翼"},
        @{@"image": @"beauty_shape_nose_long", @"name": @"长鼻"},
        @{@"image": @"beauty_shape_nose_root", @"name": @"山根"},
        @{@"image": @"beauty_shape_eyebrow_distance", @"name": @"眉间距"},
        @{@"image": @"beauty_shape_eyebrow_thin", @"name": @"眉粗细"},
        @{@"image": @"beauty_shape_mouth", @"name": @"嘴型"}];
    
    _currentTag = 100;
}

#pragma mark - Setter & Getter
- (void)setCurrentTag:(NSInteger)currentTag {
    if (_currentTag != currentTag) {
        UyaliButton *newBtn = (UyaliButton *)[self viewWithTag:currentTag];
        UyaliButton *oldBtn = (UyaliButton *)[self viewWithTag:_currentTag];
        
        newBtn.selected = YES;
        oldBtn.selected = NO;
        
        if (currentTag == 100) {//小头 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 101) {//瘦脸 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 102) {//窄脸 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 103) {//V脸 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 104) {//小脸 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 105) {//下巴 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 106) {//额头 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 107) {//颧骨 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 108) {//大眼 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 109) {//眼距 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 110) {//眼角 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 111) {//下眼睑 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 112) {//瘦鼻 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 113) {//鼻翼 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 114) {//长鼻 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 115) {//鼻子山根 done 0 - 100
            _slider.minimumValue = 0;
            _slider.maximumValue = 100;
        } else if (currentTag == 116) {//眉间距 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 117) {//眉粗细 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
        } else if (currentTag == 118) {//嘴型 done -50 - 50
            _slider.minimumValue = -50;
            _slider.maximumValue = 50;
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
        [button addTarget:self action:@selector(reshapeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)reshapeButtonAction:(UyaliButton *)button {
    self.currentTag = button.tag;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeReshapeType:)]) {
        [self.delegate changeReshapeType:button.tag];
    }
}

- (void)sliderValueChanged:(UISlider *)currentSlider {
    _valueLabel.text = [NSString stringWithFormat:@"%.1f",currentSlider.value];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getReshapeDeltaVale:type:)]) {
        [self.delegate getReshapeDeltaVale:_slider.value type:_currentTag];
    }
}

@end
