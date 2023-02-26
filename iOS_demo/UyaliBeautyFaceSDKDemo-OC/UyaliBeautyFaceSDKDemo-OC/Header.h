//
//  Header.h
//  UyaliBeautyFaceSDKDemo-OC
//
//  Created by S weet on 2023/2/27.
//

#ifndef Header_h
#define Header_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTabBarHeight self.tabBarController.tabBar.frame.size.height

#define KIsiPhoneX ((int)((kScreenHeight/kScreenWidth)*100) == 216)?YES:NO

#define kIsiPad (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define colorWithHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#endif /* Header_h */
