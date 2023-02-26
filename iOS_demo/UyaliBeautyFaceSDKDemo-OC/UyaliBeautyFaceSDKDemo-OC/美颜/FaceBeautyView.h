//
//  FaceBeautyView.h
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FaceBeautyViewDelegate <NSObject>

- (void)changeBeautyType:(NSInteger)type;
- (void)getBeautyDeltaVale:(CGFloat)value type:(NSInteger)type;

@end

@interface FaceBeautyView : UIView

@property (nonatomic, weak) id<FaceBeautyViewDelegate> delegate;

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *valueLabel;

@end

NS_ASSUME_NONNULL_END
