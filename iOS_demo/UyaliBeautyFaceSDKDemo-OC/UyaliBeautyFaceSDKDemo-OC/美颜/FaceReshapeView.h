//
//  FaceReshapeView.h
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FaceReshapeViewDelegate <NSObject>

- (void)changeReshapeType:(NSInteger)type;
- (void)getReshapeDeltaVale:(CGFloat)value type:(NSInteger)type;

@end

@interface FaceReshapeView : UIView

@property (nonatomic, weak) id<FaceReshapeViewDelegate> delegate;

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *valueLabel;

@end

NS_ASSUME_NONNULL_END
