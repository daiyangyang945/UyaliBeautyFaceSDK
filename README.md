# UyaliBeautyFaceSDK：商用级美颜SDK

UyaliBeautyFaceSDK是一个集美颜、美型、贴纸等各种功能于一体的堪比商用级的美颜SDK，目前暂时只完成了美型模块的基本开发，美颜与贴纸等功能将在后期慢慢补上。

**如果觉得这个项目可以的话，可以给个star支持一下吗，谢谢了**🙏

#### 注意：

由于是本人自研开发，或许有尚未发现的bug，商用的话建议慎重使用

## 功能规划

- 美颜：美白、磨皮、亮眼、白牙等功能（**完成美白、磨皮、亮眼、白牙等滤镜**）
- 美型：小头、瘦脸、大眼、额头、颧骨、眉毛等脸部微调功能（**已完成19款美型滤镜**）
- 美妆：眉毛、眼妆、美瞳、腮红、口红等（**已初步完成规划中所有的美妆滤镜**）
- 贴纸：规划中（未完成）
- 适配Android（未完成）

## 关于人脸关键点检测

初期采用的是Face++的SDK，由于使用次数有限，现在采用了腾讯开源的TNN，缺点是只能识别一张人脸，但是目前用于自研调试是足够了，待完成大部分功能后再考虑替换。

**注意：**由于开源人脸识别的关键点存在一定的抖动，所以在精细计算的美妆：**美瞳滤镜**中也存在一定的抖动

## 部分功能展示

演示材料来自网络，若有侵权可联系daiyangyang945@126.com删除

#### 美型：

|                             瘦脸                             |                             下巴                             |                             眼距                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![face_thin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/face_thin.gif) | ![chin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/chin.gif) | ![eye_distance](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/eye_distance.gif) |

|                             瘦鼻                             |                            眉间距                            |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![nose_thin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/nose_thin.gif) | ![eye_distance](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/eyebrow_distance.gif) |

#### 美妆：

|                          美妆：眉毛                          |                          美妆：口红                          |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![makeup_eyebrow](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/makeup_eyebrow.gif) | ![makeup_rouge](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/makeup_rouge.gif) |



#### 贴纸：

待续...

## 接入方式

将demo中的UyaliBeautyFaceSDK拷入自己的项目中即可

#### iOS接入

初始化：

```swift
private let filter = UyaliBeautyFaceEngine()
```

图像渲染处理：

```swift
filter.process(pixelBuffer: pixelBuffer!)
```

美型参数设置：

```swift
filter.faceThin_delta = 100 //瘦脸参数范围 0 - 100
```

美颜参数设置：

```swift
filter.white_delta = 100 //美白参数范围 0 - 100
```

美妆参数设置：

```swift
//美妆滤镜需要设置两个参数，第一个为美妆数值，第二个为美妆样式
filter.makeup_eyebrow_delta = 100 // 美妆：眉毛参数范围 0 - 100
filter.makeup_eyebrow_type = .eyebrow_cupin //将眉毛的样式设置为蹙颦眉
```

如果接入时，提示

> Library not loaded: @rpath/UyaliBeautyFaceSDK.framework/UyaliBeautyFaceSDK

可进入**Build Phases**,点击左上角的**加号**，选择**New Copy Files Phase**,在点击创建的**Copy Files**，将**Destination**设为**Frameworks**，点击下方的**加号**，添加**UyaliBeautyFaceSDK.framework**即可

![ios_bug](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/ios_bug.png)

#### Android接入

待续...

## 更新日志

#### 2023-03-21

**本次更新：**

1、完成美妆滤镜（眉毛、眼妆、美瞳、腮红、口红）

2、增加部分演示动画







#### 2023-02-27

**本次更新：**

1、调整微调美白和磨皮的参数

2、增加iOS的OC语言demo





#### 2023-02-24

**本次更新：**

完成亮眼滤镜和白牙滤镜







#### 2023-02-16

**本次更新：**

1、修复美型时可能产生锯齿的bug

2、完成美白磨皮功能（磨皮的内存消耗略多，后期待完善）

3、在调用UyaliBeautyFaceSDK时直接在当前获取的CVPixelBuffer的内存中进行渲染，不再需要生成一个新的CVPixelBuffer用于后续处理，SDK插拔更方便







#### 2023-01-30

**iPhone7 测试** 

|            |             美颜渲染（小头、瘦脸、大眼、瘦鼻等）             |
| :--------: | :----------------------------------------------------------: |
|  **CPU**   | ![cpu](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/cpu.png) |
| **Memory** | ![memory](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/memory.png) |
| **Energy** | ![energy](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/energy.png) |
|  **GPU**   | ![gpu](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/gpu.png) |

