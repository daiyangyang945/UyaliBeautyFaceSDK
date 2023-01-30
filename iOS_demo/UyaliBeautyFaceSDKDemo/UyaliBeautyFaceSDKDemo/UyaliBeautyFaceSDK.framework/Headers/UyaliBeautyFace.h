//
//  UyaliBeautyFace.h
//  美颜测试
//
//  Created by S weet on 2023/1/28.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>

NS_ASSUME_NONNULL_BEGIN

@interface UyaliBeautyFace : NSObject

- (NSString *)getFilterContent:(NSString *)shaderName;

@end

NS_ASSUME_NONNULL_END
