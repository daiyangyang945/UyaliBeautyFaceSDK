//
//  FaceLandmarks.h
//  美颜测试
//
//  Created by S weet on 2023/1/3.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceLandmarks : NSObject

@property (nonatomic, assign)BOOL showLandmarks;
@property (nonatomic, strong)UIView *renderView;

@property (nonatomic, copy)NSArray<NSValue *> *landmarks;

- (void)getFaceLandmarks:(CVPixelBufferRef)pixelBuffer;

@end

NS_ASSUME_NONNULL_END
