//
//  UyaliBeautyFaceEngine.swift
//  美颜测试
//
//  Created by S weet on 2023/2/15.
//

import UIKit
import CoreMedia
import GLKit
import VideoToolbox

public class UyaliBeautyFaceEngine: NSObject {
    /// 美颜处理器
    private var processor = BeautyFaceProcessor()
    
    //MARK: 美型参数
    /// 小头，参数范围：0.0 - 100.0
    @objc public var headReduce_delta: Float = 0.0 {
        didSet {
            processor.headReduce_delta = headReduce_delta
        }
    }
    
    /// 瘦脸，参数范围：0.0 - 100.0
    @objc public var faceThin_delta: Float = 0.0 {
        didSet {
            processor.faceThin_delta = faceThin_delta
        }
    }
    
    /// 窄脸，参数范围：0.0 - 100.0
    @objc public var faceNarrow_delta: Float = 0.0 {
        didSet {
            processor.faceNarrow_delta = faceNarrow_delta
        }
    }
    
    /// V脸，参数范围：0.0 - 100.0
    @objc public var faceV_delta: Float = 0.0 {
        didSet {
            processor.faceV_delta = faceV_delta
        }
    }
    
    /// 小脸，参数范围：0.0 - 100.0
    @objc public var faceSmall_delta: Float = 0.0 {
        didSet {
            processor.faceSmall_delta = faceSmall_delta
        }
    }
    
    /// 下巴，参数范围：-50.0 - 50.0
    @objc public var chin_delta: Float = 0.0 {
        didSet {
            processor.chin_delta = chin_delta
        }
    }
    
    /// 额头，参数范围：-50.0 - 50.0
    @objc public var forehead_delta: Float = 0.0 {
        didSet {
            processor.forehead_delta = forehead_delta
        }
    }
    
    /// 颧骨，参数范围：-50.0 - 50.0
    @objc public var cheekbone_delta: Float = 0.0 {
        didSet {
            processor.cheekbone_delta = cheekbone_delta
        }
    }
    
    /// 大眼，参数范围：0.0 - 100.0
    @objc public var eyeBig_delta: Float = 0.0 {
        didSet {
            processor.eyeBig_delta = eyeBig_delta
        }
    }
    
    /// 眼距，参数范围：-50.0 - 50.0
    @objc public var eyeDistance_delta: Float = 0.0 {
        didSet {
            processor.eyeDistance_delta = eyeDistance_delta
        }
    }
    
    /// 内眼角，参数范围：0.0 - 100.0
    @objc public var eyeCorner_delta: Float = 0.0 {
        didSet {
            processor.eyeCorner_delta = eyeCorner_delta
        }
    }
    
    /// 眼睑下至，参数范围：0.0 - 100.0
    @objc public var eyelidDown_delta: Float = 0.0 {
        didSet {
            processor.eyelidDown_delta = eyelidDown_delta
        }
    }
    
    /// 瘦鼻，参数范围：0.0 - 100.0
    @objc public var noseThin_delta: Float = 0.0 {
        didSet {
            processor.noseThin_delta = noseThin_delta
        }
    }
    
    /// 鼻翼，参数范围：0.0 - 100.0
    @objc public var noseWing_delta: Float = 0.0 {
        didSet {
            processor.noseWing_delta = noseWing_delta
        }
    }
    
    /// 长鼻，参数范围：-50.0 - 50.0
    @objc public var noseLong_delta: Float = 0.0 {
        didSet {
            processor.noseLong_delta = noseLong_delta
        }
    }
    
    /// 山根，参数范围：0.0 - 100.0
    @objc public var noseRoot_delta: Float = 0.0 {
        didSet {
            processor.noseRoot_delta = noseRoot_delta
        }
    }
    
    /// 眉间距，参数范围：-50.0 - 50.0
    @objc public var eyebrowDistance_delta: Float = 0.0 {
        didSet {
            processor.eyebrowDistance_delta = eyebrowDistance_delta
        }
    }
    
    /// 眉粗细，参数范围：-50.0 - 50.0
    @objc public var eyebrowThin_delta: Float = 0.0 {
        didSet {
            processor.eyebrowThin_delta = eyebrowThin_delta
        }
    }
    
    /// 嘴型，参数范围：-50.0 - 50.0
    @objc public var mouth_delta: Float = 0.0 {
        didSet {
            processor.mouth_delta = mouth_delta
        }
    }
    
    //MARK: 美白磨皮参数
    ///美白，参数范围：0.0 - 100.0
    @objc public var white_delta: Float = 0.0 {
        didSet {
            processor.white_delta = white_delta
        }
    }
    
    ///磨皮，参数范围： 0.0 - 100.0
    @objc public var skin_delta: Float = 0.0 {
        didSet {
            processor.skin_delta = skin_delta
        }
    }
    
    ///亮眼，参数范围：0.0 - 100.0
    @objc public var eyeBright_delta: Float = 0.0 {
        didSet {
            processor.eyeBright_delta = eyeBright_delta
        }
    }
    
    ///白牙，参数范围： 0.0 - 100.0
    @objc public var teethBright_delta: Float = 0.0 {
        didSet {
            processor.teethBright_delta = teethBright_delta
        }
    }
    
    //MARK: 美妆参数
    ///眉毛，参数范围：0.0 - 100.0
    @objc public var makeup_eyebrow_delta: Float = 0.0 {
        didSet {
            processor.makeup_eyebrow_delta = makeup_eyebrow_delta
        }
    }
    ///眉毛类型
    @objc public var makeup_eyebrow_type: MakeupEyebrowType = .eyebrow_none {
        didSet {
            processor.makeup_eyebrow_type = makeup_eyebrow_type
        }
    }
    
    ///眼妆，参数范围： 0.0 - 100.0
    @objc public var makeup_eyeshadow_delta: Float = 0.0 {
        didSet {
            processor.makeup_eyeshadow_delta = makeup_eyeshadow_delta
        }
    }
    ///眼妆类型
    @objc public var makeup_eyeshadow_type: MakeupEyeshadowType = .eyeshadow_none {
        didSet {
            processor.makeup_eyeshadow_type = makeup_eyeshadow_type
        }
    }
    
    ///美瞳，参数范围：0.0 - 100.0
    @objc public var makeup_pupil_delta: Float = 0.0 {
        didSet {
            processor.makeup_pupil_delta = makeup_pupil_delta
        }
    }
    ///美瞳类型
    @objc public var makeup_pupil_type: MakeupPupilType = .pupil_none {
        didSet {
            processor.makeup_pupil_type = makeup_pupil_type
        }
    }
    
    ///腮红，参数范围：0.0 - 100.0
    @objc public var makeup_blush_delta: Float = 0.0 {
        didSet {
            processor.makeup_blush_delta = makeup_blush_delta
        }
    }
    ///腮红类型
    @objc public var makeup_blush_type: MakeupBlushType = .blush_none {
        didSet {
            processor.makeup_blush_type = makeup_blush_type
        }
    }
    
    ///口红，参数范围：0.0 - 100.0
    @objc public var makeup_rouge_delta: Float = 0.0 {
        didSet {
            processor.makeup_rouge_delta = makeup_rouge_delta
        }
    }
    ///口红类型
    @objc public var makeup_rouge_type: MakeupRougeType = .rouge_none {
        didSet {
            processor.makeup_rouge_type = makeup_rouge_type
        }
    }
    
    //MARK: 常规滤镜
    ///常规滤镜，参数范围：0.0 - 100.0
    @objc public var filter_delta: Float = 0.0 {
        didSet {
            processor.filter_delta = filter_delta
        }
    }
    
    ///常规滤镜名称（暂时）
    @objc public var filter_name: String = "normal1" {
        didSet {
            processor.filter_name = filter_name
        }
    }
    
    @objc public var filter_image: UIImage? {
        didSet {
            processor.filter_image = filter_image
        }
    }
    
    //MARK: 绿幕抠图参数（该功能仅为测试，效果不佳，不建议使用）
    ///绿幕抠图开关
    @objc public var isOpenGreenScreen: Bool = false {
        didSet {
            processor.isOpenGreenScreen = isOpenGreenScreen
        }
    }
    
    ///绿幕类型
    @objc public var greenScreen_type: GreenScreenType = .greenScreen_green {
        didSet {
            processor.greenScreen_type = greenScreen_type
        }
    }
    
    ///绿幕抠图，参数范围：0.0 - 100.0
    @objc public var greenScreen_delta: Float = 0.0 {
        didSet {
            processor.greenScreen_delta = greenScreen_delta
        }
    }
    
    ///填充绿幕的背景图（建议先按CVPixelBuffer的比例裁剪好尺寸）
    @objc public var greenScreen_background = UIImage() {
        didSet {
            processor.greenScreen_background = greenScreen_background
        }
    }
    
    @objc public override init() {}
    
    //MARK: CVPixelBuffer处理（当前仅支持RGBA格式）
    @objc public func process(pixelBuffer:CVPixelBuffer) {
        processor.filter(pixelBuffer: pixelBuffer)
    }
    
    @objc public func processWithOutput(pixelBuffer: CVPixelBuffer) -> CVPixelBuffer {
        return processor.filterWithOutput(pixelBuffer: pixelBuffer)
    }
    
    //MARK: 重置所有滤镜的参数
    @objc public func resetAllFilters() {
        //美型参数
        headReduce_delta = 0.0
        faceThin_delta = 0.0
        faceNarrow_delta = 0.0
        faceV_delta = 0.0
        faceSmall_delta = 0.0
        chin_delta = 0.0
        forehead_delta = 0.0
        cheekbone_delta = 0.0
        eyeBig_delta = 0.0
        eyeDistance_delta = 0.0
        eyeCorner_delta = 0.0
        eyelidDown_delta = 0.0
        noseThin_delta = 0.0
        noseWing_delta = 0.0
        noseLong_delta = 0.0
        noseRoot_delta = 0.0
        eyebrowDistance_delta = 0.0
        eyebrowThin_delta = 0.0
        mouth_delta = 0.0
        //美颜参数
        white_delta = 0.0
        skin_delta = 0.0
        eyeBright_delta = 0.0
        teethBright_delta = 0.0
        //美妆参数
        makeup_eyebrow_delta = 0.0
        makeup_eyebrow_type = .eyebrow_none
        makeup_eyeshadow_delta = 0.0
        makeup_eyeshadow_type = .eyeshadow_none
        makeup_pupil_delta = 0.0
        makeup_pupil_type = .pupil_none
        makeup_blush_delta = 0.0
        makeup_blush_type = .blush_none
        makeup_rouge_delta = 0.0
        makeup_rouge_type = .rouge_none
        //滤镜参数
        filter_delta = 0.0
        filter_name = "normal1"
    }
}
