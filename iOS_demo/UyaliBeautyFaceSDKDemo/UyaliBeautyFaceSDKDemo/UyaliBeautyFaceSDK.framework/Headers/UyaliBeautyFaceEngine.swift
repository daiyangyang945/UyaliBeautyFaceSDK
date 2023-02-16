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

public class UyaliBeautyFaceEngine {
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
    
    @objc public init() {}
    
    //MARK: CVPixelBuffer处理（当前仅支持RGBA格式）
    @objc public func process(pixelBuffer:CVPixelBuffer) {
        processor.filter(pixelBuffer: pixelBuffer)
    }
}
