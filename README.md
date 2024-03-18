# UyaliBeautyFaceSDK：Commercial-grade beauty enhancement SDK

UyaliBeautyFaceSDK is a comprehensive beauty enhancement SDK comparable to commercial-grade standards, integrating various functions such as beauty enhancement, facial shaping, and stickers. Currently, only the basic development of the facial shaping module has been completed, with beauty enhancement and sticker features to be gradually added in later stages.

**If you think this project is good, could you give it a star to show your support? Thank you!**🙏



**English**/[中文](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/README_CN.md)



#### Attention:


Note: As this is self-developed, there may be undiscovered bugs. It is advisable to use with caution for commercial purposes.

## 
Function Planning

- Beauty: Functions include whitening, smoothing, brightening eyes, whitening teeth, etc.（**Completed filters for whitening, smoothing, brightening eyes, and whitening teeth.**）
- Reshape: Features for adjusting facial aspects such as small head, slim face, large eyes, forehead, cheekbones, eyebrows, etc.（**Nineteen facial enhancement filters have been completed.**）
- Makeup: Features include eyebrows, eye makeup, contact lenses, blush, lipstick, etc.（**Preliminary planning for all cosmetic filters has been completed.**）
- Stickers: Planned (Not Completed)
- Adaptation for Android (Not Completed)


## Partial Feature Showcase

Demonstration materials are sourced from the internet. If there are any copyright concerns, please contact daiyangyang945@126.com for removal.

#### Reshape：

|                             Face                             |                             Chin                             |                         Eye distance                         |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![face_thin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/face_thin.gif) | ![chin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/chin.gif) | ![eye_distance](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/eye_distance.gif) |

|                             Nose                             |                       Eyebrow distance                       |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![nose_thin](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/nose_thin.gif) | ![eye_distance](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/eyebrow_distance.gif) |

#### 美妆：

|                       Makeup: eyebrow                        |                       Makeup: Lipstick                       |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![makeup_eyebrow](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/makeup_eyebrow.gif) | ![makeup_rouge](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/gif/makeup_rouge.gif) |



#### Stickers：

To be continued...

## Integration Method

Simply copy the UyaliBeautyFaceSDK from the demo into your own project.

#### iOS

Initialization：

```swift
private let filter = UyaliBeautyFaceEngine()
```

Image Rendering Processing：

```swift
filter.process(pixelBuffer: pixelBuffer!)
```

Reshape Parameter Configuration：

```swift
filter.faceThin_delta = 100 //Range of Slimming Parameters for the Face 0 - 100
```

Beauty Parameter Configuration：

```swift
filter.white_delta = 100 //Range of Whitening Parameters 0 - 100
```

Makeup Parameter Configuration：

```swift
//Makeup filters require two parameters to be set: the first one is the makeup intensity value, and the second one is the makeup style.
filter.makeup_eyebrow_delta = 100 // Makeup: Eyebrow Parameter Range 0 - 100
filter.makeup_eyebrow_type = .eyebrow_cupin //Set the style of the eyebrows to "Cupin".
```

If there are prompts during integration,

> Library not loaded: @rpath/UyaliBeautyFaceSDK.framework/UyaliBeautyFaceSDK

You can enter **Build Phases**, click on the **plus sign** at the top left corner, select **New Copy Files Phase**, then click on the created **Copy Files**. Set **Destination** to **Frameworks**, then click on the **plus sign** below and add **UyaliBeautyFaceSDK.framework**.

![ios_bug](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/ios_bug.png)

#### Android

To be continued

#### 

**iPhone7 测试** 

|            |             美颜渲染（小头、瘦脸、大眼、瘦鼻等）             |
| :--------: | :----------------------------------------------------------: |
|  **CPU**   | ![cpu](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/cpu.png) |
| **Memory** | ![memory](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/memory.png) |
| **Energy** | ![energy](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/energy.png) |
|  **GPU**   | ![gpu](https://github.com/daiyangyang945/UyaliBeautyFaceSDK/blob/main/screenshot/gpu.png) |

