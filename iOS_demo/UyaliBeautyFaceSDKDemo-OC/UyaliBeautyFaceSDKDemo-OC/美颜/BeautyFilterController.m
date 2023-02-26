//
//  BeautyFilterController.m
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import "BeautyFilterController.h"
#import "FaceReshapeView.h"
#import "FaceBeautyView.h"
#import "PFOpenGLView.h"
#import "PFCamera.h"

#import <UyaliBeautyFaceSDK/UyaliBeautyFaceSDK.h>

@interface BeautyFilterController ()<PFCameraDelegate, FaceBeautyViewDelegate, FaceReshapeViewDelegate>

@property (nonatomic, strong) PFCamera *camera;
@property (nonatomic, strong) PFOpenGLView *openGLView;

@property (nonatomic, strong) UIView *beautyFilterView;
@property (nonatomic, strong) FaceReshapeView *reshapeView;
@property (nonatomic, strong) FaceBeautyView *beautyView;

@property (nonatomic, strong) UyaliBeautyFaceEngine *filter;

@property (nonatomic, assign) BOOL isFront;

@property (nonatomic, assign) NSInteger currentShow;

@end

@implementation BeautyFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat bottomHeight = 0;
    if (KIsiPhoneX) {
        bottomHeight = 34.0;
    }
    
    _filter = [UyaliBeautyFaceEngine new];
    _isFront = true;
    _currentShow = 0;
    
    _camera = [PFCamera new];
    _camera.delegate = self;
    [_camera startCapture];
    
    _openGLView = [[PFOpenGLView alloc]initWithFrame:self.view.bounds context:[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3]];
    [self.view addSubview:_openGLView];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 60, 50, 50)];
    [self.view addSubview:closeButton];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-58, 60, 50, 50)];
    [self.view addSubview:changeButton];
    [changeButton setTitle:@"切换" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    
    _beautyFilterView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50-bottomHeight, kScreenWidth, 50+bottomHeight)];
    [self.view addSubview:_beautyFilterView];
    _beautyFilterView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    NSArray *items = @[@"美颜",@"美型"];
    for (NSInteger i = 0; i < items.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/items.count*i, 0, kScreenWidth/items.count, 50)];
        [_beautyFilterView addSubview:button];
        [button setTitle:items[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+i;
    }
    
    //美型滤镜
    _reshapeView = [[FaceReshapeView alloc]initWithFrame:CGRectMake(0, _beautyFilterView.frame.origin.y, kScreenWidth, 130)];
    [self.view addSubview:_reshapeView];
    _reshapeView.alpha = 0;
    _reshapeView.hidden = YES;
    _reshapeView.delegate = self;
    
    //美颜滤镜
    _beautyView = [[FaceBeautyView alloc]initWithFrame:_reshapeView.frame];
    [self.view addSubview:_beautyView];
    _beautyView.alpha = 0;
    _beautyView.hidden = YES;
    _beautyView.delegate = self;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50-bottomHeight, kScreenWidth, 1)];
    [self.view addSubview:line];
    line.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Setter & Getter
- (void)setCurrentShow:(NSInteger)currentShow {
    if (_currentShow == 0) {//当没有选择任何一种滤镜集合时，只需要弹出即可
        if (currentShow == 1000) {//美颜
            _beautyView.hidden = NO;
            [UIView animateWithDuration:0.15 animations:^{
                self.beautyView.frame = CGRectMake(0, self.beautyView.frame.origin.y-self.beautyView.frame.size.height, self.beautyView.frame.size.width, self.beautyView.frame.size.height);
                self.beautyView.alpha = 1;
            }];
        } else if (currentShow == 1001) {//美型
            _reshapeView.hidden = NO;
            [UIView animateWithDuration:0.15 animations:^{
                self.reshapeView.frame = CGRectMake(0, self.reshapeView.frame.origin.y-self.reshapeView.frame.size.height, self.reshapeView.frame.size.width, self.reshapeView.frame.size.height);
                self.reshapeView.alpha = 1;
            }];
        }
        _currentShow = currentShow;
    } else if (_currentShow == currentShow) {//当选择了当前展示的滤镜集合时，只需要弹回即可
        if (currentShow == 1000) {//美颜
            [UIView animateWithDuration:0.15 animations:^{
                self.beautyView.frame = CGRectMake(0, self.beautyFilterView.frame.origin.y, self.beautyView.frame.size.width, self.beautyView.frame.size.height);
                self.beautyView.alpha = 0;
            } completion:^(BOOL finished) {
                self.beautyView.hidden = YES;
            }];
        } else if (currentShow == 1001) {//美型
            [UIView animateWithDuration:0.15 animations:^{
                self.reshapeView.frame = CGRectMake(0, self.beautyFilterView.frame.origin.y, self.reshapeView.frame.size.width, self.reshapeView.frame.size.height);
                self.reshapeView.alpha = 0;
            } completion:^(BOOL finished) {
                self.reshapeView.hidden = YES;
            }];
        }
        _currentShow = 0;
    } else if (_currentShow != currentShow) {//当选择了和当前展示的滤镜集合不同的滤镜集合时，弹回展示的滤镜集合并弹出选择的滤镜集合
        //弹出
        if (currentShow == 1000) {//美颜
            _beautyView.hidden = NO;
            [UIView animateWithDuration:0.15 animations:^{
                self.beautyView.frame = CGRectMake(0, self.beautyView.frame.origin.y-self.beautyView.frame.size.height, self.beautyView.frame.size.width, self.beautyView.frame.size.height);
                self.beautyView.alpha = 1;
            }];
        } else if (currentShow == 1001) {//美型
            _reshapeView.hidden = NO;
            [UIView animateWithDuration:0.15 animations:^{
                self.reshapeView.frame = CGRectMake(0, self.reshapeView.frame.origin.y-self.reshapeView.frame.size.height, self.reshapeView.frame.size.width, self.reshapeView.frame.size.height);
                self.reshapeView.alpha = 1;
            }];
        }
        //弹回
        if (_currentShow == 1000) {//美颜
            [UIView animateWithDuration:0.15 animations:^{
                self.beautyView.frame = CGRectMake(0, self.beautyFilterView.frame.origin.y, self.beautyView.frame.size.width, self.beautyView.frame.size.height);
                self.beautyView.alpha = 0;
            } completion:^(BOOL finished) {
                self.beautyView.hidden = YES;
            }];
        } else if (_currentShow == 1001) {//美型
            [UIView animateWithDuration:0.15 animations:^{
                self.reshapeView.frame = CGRectMake(0, self.beautyFilterView.frame.origin.y, self.reshapeView.frame.size.width, self.reshapeView.frame.size.height);
                self.reshapeView.alpha = 0;
            } completion:^(BOOL finished) {
                self.reshapeView.hidden = YES;
            }];
        }
        _currentShow = currentShow;
    }
}

#pragma mark - PF Camera Delegate
- (void)didOutputVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if (pixelBuffer == nil) {
        return;
    }
    [_filter processWithPixelBuffer:pixelBuffer];
    [_openGLView displayPixelBuffer:pixelBuffer];
}

#pragma mark - Beauty Delegate
//在切换滤镜时，将当前滤镜的参数赋值给Slider
- (void)changeBeautyType:(NSInteger)type {
    if (type == 100) {//美白 参数范围：0 - 100
        _beautyView.slider.value = _filter.white_delta;
    } else if (type == 101) {//磨皮 参数范围 0 - 100
        _beautyView.slider.value = _filter.skin_delta;
    } else if (type == 102) {//亮眼 参数范围 0 - 100
        _beautyView.slider.value = _filter.eyeBright_delta;
    } else if (type == 103) {//白牙 参数范围 0 - 100
        _beautyView.slider.value = _filter.teethBright_delta;
    }
    _beautyView.valueLabel.text = [NSString stringWithFormat:@"%.1f",_beautyView.slider.value];
}

//将slider的value作为参数赋值给对应的滤镜
- (void)getBeautyDeltaVale:(CGFloat)value type:(NSInteger)type {
    if (type == 100) {//美白 参数范围：0 - 100
        _filter.white_delta = value;
    } else if (type == 101) {//磨皮 参数范围 0 - 100
        _filter.skin_delta = value;
    } else if (type == 102) {//亮眼 参数范围 0 - 100
        _filter.eyeBright_delta = value;
    } else if (type == 103) {//白牙 参数范围 0 - 100
        _filter.teethBright_delta = value;
    }
}

#pragma mark - Reshape Delegate
//在切换滤镜时，将当前滤镜的参数赋值给Slider
- (void)changeReshapeType:(NSInteger)type {
    if (type == 100) {//小头 参数范围：0 - 100
        _reshapeView.slider.value = _filter.headReduce_delta;
    } else if (type == 101) {//瘦脸 参数范围：0 - 100
        _reshapeView.slider.value = _filter.faceThin_delta;
    } else if (type == 102) {//窄脸 参数范围：0 - 100
        _reshapeView.slider.value = _filter.faceNarrow_delta;
    } else if (type == 103) {//V脸 参数范围：0 - 100
        _reshapeView.slider.value = _filter.faceV_delta;
    } else if (type == 104) {//小脸 参数范围：0 - 100
        _reshapeView.slider.value = _filter.faceSmall_delta;
    } else if (type == 105) {//下巴 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.chin_delta;
    } else if (type == 106) {//额头 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.forehead_delta;
    } else if (type == 107) {//颧骨 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.cheekbone_delta;
    } else if (type == 108) {//大眼 参数范围：0 - 100
        _reshapeView.slider.value = _filter.eyeBig_delta;
    } else if (type == 109) {//眼距 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.eyeDistance_delta;
    } else if (type == 110) {//眼角 参数范围：0 - 100
        _reshapeView.slider.value = _filter.eyeCorner_delta;
    } else if (type == 111) {//下眼睑 0 - 100
        _reshapeView.slider.value = _filter.eyelidDown_delta;
    } else if (type == 112) {//瘦鼻 参数范围：0 - 100
        _reshapeView.slider.value = _filter.noseThin_delta;
    } else if (type == 113) {//鼻翼 参数范围：0 - 100
        _reshapeView.slider.value = _filter.noseWing_delta;
    } else if (type == 114) {//长鼻 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.noseLong_delta;
    } else if (type == 115) {//鼻子山根 参数范围：0 - 100
        _reshapeView.slider.value = _filter.noseRoot_delta;
    } else if (type == 116) {//眉间距 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.eyebrowDistance_delta;
    } else if (type == 117) {//眉粗细 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.eyebrowThin_delta;
    } else if (type == 118) {//嘴型 参数范围：-50 - 50
        _reshapeView.slider.value = _filter.mouth_delta;
    }
    _reshapeView.valueLabel.text = [NSString stringWithFormat:@"%.1f",_reshapeView.slider.value];
}

//将slider的value作为参数赋值给对应的滤镜
- (void)getReshapeDeltaVale:(CGFloat)value type:(NSInteger)type {
    if (type == 100) {//小头 参数范围：0 - 100
        _filter.headReduce_delta = value;
    } else if (type == 101) {//瘦脸 参数范围：0 - 100
        _filter.faceThin_delta = value;
    } else if (type == 102) {//窄脸 参数范围：0 - 100
        _filter.faceNarrow_delta = value;
    } else if (type == 103) {//V脸 参数范围：0 - 100
        _filter.faceV_delta = value;
    } else if (type == 104) {//小脸 参数范围：0 - 100
        _filter.faceSmall_delta = value;
    } else if (type == 105) {//下巴 参数范围：-50 - 50
        _filter.chin_delta = value;
    } else if (type == 106) {//额头 参数范围：-50 - 50
        _filter.forehead_delta = value;
    } else if (type == 107) {//颧骨 参数范围：-50 - 50
        _filter.cheekbone_delta = value;
    } else if (type == 108) {//大眼 参数范围：0 - 100
        _filter.eyeBig_delta = value;
    } else if (type == 109) {//眼距 参数范围：-50 - 50
        _filter.eyeDistance_delta = value;
    } else if (type == 110) {//眼角 参数范围：0 - 100
        _filter.eyeCorner_delta = value;
    } else if (type == 111) {//下眼睑 0 - 100
        _filter.eyelidDown_delta = value;
    } else if (type == 112) {//瘦鼻 参数范围：0 - 100
        _filter.noseThin_delta = value;
    } else if (type == 113) {//鼻翼 参数范围：0 - 100
        _filter.noseWing_delta = value;
    } else if (type == 114) {//长鼻 参数范围：-50 - 50
        _filter.noseLong_delta = value;
    } else if (type == 115) {//鼻子山根 参数范围：0 - 100
        _filter.noseRoot_delta = value;
    } else if (type == 116) {//眉间距 参数范围：-50 - 50
        _filter.eyebrowDistance_delta = value;
    } else if (type == 117) {//眉粗细 参数范围：-50 - 50
        _filter.eyebrowThin_delta = value;
    } else if (type == 118) {//嘴型 参数范围：-50 - 50
        _filter.mouth_delta = value;
    }
}

#pragma mark - Action
- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeAction {
    _isFront = !_isFront;
    [_camera changeCameraInputDeviceisFront:_isFront];
}

- (void)itemButtonAction:(UIButton *)button {
    self.currentShow = button.tag;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
