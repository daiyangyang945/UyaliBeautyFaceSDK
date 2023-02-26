//
//  UyaliButton.m
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#import "UyaliButton.h"

@implementation UyaliButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Setter & Getter
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.imageView.tintColor = [UIColor systemBlueColor];
    } else {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        self.imageView.tintColor = [UIColor whiteColor];
    }
}

#pragma mark - UI
- (void)setupView {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.imageView.tintColor = [UIColor whiteColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor systemBlueColor] forState:UIControlStateSelected];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * 0.5;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.5;
    return CGRectMake(0, 5, imageW, imageH);
}

@end
