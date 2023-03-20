//
//  BeautyFilterController.swift
//  UyaliBeautyFaceSDKDemo
//
//  Created by S weet on 2023/2/16.
//

import UIKit
import UyaliBeautyFaceSDK

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kstatusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height

public func kIsIpnoneX() -> Bool {
    if (Int)((kScreenHeight/kScreenWidth)*100) == 216 {
        return true
    }
    else {
        return false
    }
}

class BeautyFilterController: UIViewController,PFCameraDelegate,FaceReshapeDelegate,FaceBeautyDelegate,FaceMakeupDelegate {
    
    private var camera: PFCamera!
    private var openGLView: PFOpenGLView!
    
    private var beautyFilterView : UIView!
    private var reshapeView : FaceReshapeView!
    private var beautyView: FaceBeautyView!
    private var makeupView: FaceMakeupView!
    
    private let filter = UyaliBeautyFaceEngine()
    
    private var isFront = true
    private var currentShow = 0 {
        didSet {
            if oldValue == 0 {//当没有选择任何一种滤镜集合时，只需要弹出即可
                if currentShow == 1000 {//美颜
                    beautyView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        beautyView.frame = CGRect(x: 0, y: beautyView.frame.origin.y-beautyView.frame.height, width: beautyView.frame.width, height: beautyView.frame.height)
                        beautyView.alpha = 1
                    }
                } else if currentShow == 1001 {//美型
                    reshapeView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        reshapeView.frame = CGRect(x: 0, y: reshapeView.frame.origin.y-reshapeView.frame.height, width: reshapeView.frame.width, height: reshapeView.frame.height)
                        reshapeView.alpha = 1
                    }
                } else if currentShow == 1002 {//美妆
                    makeupView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        makeupView.frame = CGRect(x: 0, y: makeupView.frame.origin.y-makeupView.frame.height, width: makeupView.frame.width, height: makeupView.frame.height)
                        makeupView.alpha = 1
                    }
                }
            } else if oldValue == currentShow {//当选择了当前展示的滤镜集合时，只需要弹回即可
                if currentShow == 1000 {//美颜
                    UIView.animate(withDuration: 0.15) {[self] in
                        beautyView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: reshapeView.frame.width, height: beautyView.frame.height)
                        beautyView.alpha = 0
                    } completion: {[self] finished in
                        beautyView.isHidden = true
                    }
                } else if currentShow == 1001 {//美型
                    UIView.animate(withDuration: 0.15) {[self] in
                        reshapeView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: reshapeView.frame.width, height: reshapeView.frame.height)
                        reshapeView.alpha = 0
                    } completion: {[self] finished in
                        reshapeView.isHidden = true
                    }
                } else if currentShow == 1002 {//美妆
                    UIView.animate(withDuration: 0.15) {[self] in
                        makeupView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: makeupView.frame.width, height: makeupView.frame.height)
                        makeupView.alpha = 0
                    } completion: {[self] finished in
                        makeupView.isHidden = true
                    }
                }
                currentShow = 0
            } else if oldValue != currentShow {//当选择了和当前展示的滤镜集合不同的滤镜集合时，弹回展示的滤镜集合并弹出选择的滤镜集合
                //弹出
                if currentShow == 1000 {//美颜
                    beautyView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        beautyView.frame = CGRect(x: 0, y: beautyView.frame.origin.y-beautyView.frame.height, width: beautyView.frame.width, height: beautyView.frame.height)
                        beautyView.alpha = 1
                    }
                } else if currentShow == 1001 {//美型
                    reshapeView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        reshapeView.frame = CGRect(x: 0, y: reshapeView.frame.origin.y-reshapeView.frame.height, width: reshapeView.frame.width, height: reshapeView.frame.height)
                        reshapeView.alpha = 1
                    }
                } else if currentShow == 1002 {//美妆
                    makeupView.isHidden = false
                    UIView.animate(withDuration: 0.15) {[self] in
                        makeupView.frame = CGRect(x: 0, y: makeupView.frame.origin.y-makeupView.frame.height, width: makeupView.frame.width, height: makeupView.frame.height)
                        makeupView.alpha = 1
                    }
                }
                //弹回
                if oldValue == 1000 {//美颜
                    UIView.animate(withDuration: 0.15) {[self] in
                        beautyView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: reshapeView.frame.width, height: beautyView.frame.height)
                        beautyView.alpha = 0
                    } completion: {[self] finished in
                        beautyView.isHidden = true
                    }
                } else if oldValue == 1001 {//美型
                    UIView.animate(withDuration: 0.15) {[self] in
                        reshapeView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: reshapeView.frame.width, height: reshapeView.frame.height)
                        reshapeView.alpha = 0
                    } completion: {[self] finished in
                        reshapeView.isHidden = true
                    }
                } else if oldValue == 1002 {//美型
                    UIView.animate(withDuration: 0.15) {[self] in
                        makeupView.frame = CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: makeupView.frame.width, height: makeupView.frame.height)
                        makeupView.alpha = 0
                    } completion: {[self] finished in
                        makeupView.isHidden = true
                    }
                }
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var bottomHeight = 0.0
        if kIsIpnoneX() {
            bottomHeight = 34.0
        }
        camera = PFCamera()
        camera.delegate = self
        camera.startCapture()
        
        openGLView = PFOpenGLView(frame: view.bounds, context: EAGLContext(api: .openGLES3)!)
        view.addSubview(openGLView)
        
        let closeButton = UIButton(frame: CGRect(x: 8, y: 60, width: 50, height: 50))
        view.addSubview(closeButton)
        closeButton .setTitle("关闭", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        let change = UIButton(frame: CGRect(x: kScreenWidth-58, y: 60, width: 50, height: 50))
        view.addSubview(change)
        change.setTitle("切换", for: .normal)
        change.setTitleColor(.systemBlue, for: .normal)
        change.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
        
        beautyFilterView = UIView(frame: CGRect(x: 0, y: kScreenHeight-50.0-bottomHeight, width: kScreenWidth, height: 50.0+bottomHeight))
        view.addSubview(beautyFilterView)
        beautyFilterView.backgroundColor = .black.withAlphaComponent(0.4)
        
        let items = ["美颜","美型","美妆"]
        for i in 0..<items.count {
            let button = UIButton(frame: CGRect(x: kScreenWidth/CGFloat(items.count)*CGFloat(i), y: 0, width: kScreenWidth/CGFloat(items.count), height: 50.0))
            beautyFilterView.addSubview(button)
            button.setTitle(items[i], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(itemButtonAction(button:)), for: .touchUpInside)
            button.tag = 1000+i
        }
        
        //Reshape View
        reshapeView = FaceReshapeView(frame: CGRect(x: 0, y: beautyFilterView.frame.origin.y, width: kScreenWidth, height: 130.0))
        view.addSubview(reshapeView)
        reshapeView.alpha = 0
        reshapeView.isHidden = true
        reshapeView.delegate = self
        
        //Beauty View
        beautyView = FaceBeautyView(frame: reshapeView.frame)
        view.addSubview(beautyView)
        beautyView.alpha = 0
        beautyView.isHidden = true
        beautyView.delegate = self
        
        makeupView = FaceMakeupView(frame: reshapeView.frame)
        view.addSubview(makeupView)
        makeupView.alpha = 0
        makeupView.isHidden = true
        makeupView.delegate = self
        
        let line = UIView(frame: CGRect(x: 0, y: kScreenHeight-50.0-bottomHeight, width: kScreenWidth, height: 1.0))
        view.addSubview(line)
        line.backgroundColor = .white
    }
    
    //MARK: Camera Delegate
    func didOutputVideoSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        if pixelBuffer == nil {
            return
        }
        filter.process(pixelBuffer: pixelBuffer!)
        openGLView.display(pixelBuffer)
    }
    
    //MARK: Reshape Delegate
    //在切换滤镜时，将当前滤镜的参数赋值给Slider
    func changeReshapeType(type: Int) {
        if type == 100 {//小头 参数范围：0 - 100
            reshapeView.slider.value = filter.headReduce_delta
        } else if type == 101 {//瘦脸 参数范围：0 - 100
            reshapeView.slider.value = filter.faceThin_delta
        } else if type == 102 {//窄脸 参数范围：0 - 100
            reshapeView.slider.value = filter.faceNarrow_delta
        } else if type == 103 {//V脸 参数范围：0 - 100
            reshapeView.slider.value = filter.faceV_delta
        } else if type == 104 {//小脸 参数范围：0 - 100
            reshapeView.slider.value = filter.faceSmall_delta
        } else if type == 105 {//下巴 参数范围：-50 - 50
            reshapeView.slider.value = filter.chin_delta
        } else if type == 106 {//额头 参数范围：-50 - 50
            reshapeView.slider.value = filter.forehead_delta
        } else if type == 107 {//颧骨 参数范围：-50 - 50
            reshapeView.slider.value = filter.cheekbone_delta
        } else if type == 108 {//大眼 参数范围：0 - 100
            reshapeView.slider.value = filter.eyeBig_delta
        } else if type == 109 {//眼距 参数范围：-50 - 50
            reshapeView.slider.value = filter.eyeDistance_delta
        } else if type == 110 {//眼角 参数范围：0 - 100
            reshapeView.slider.value = filter.eyeCorner_delta
        } else if type == 111 {//下眼睑 0 - 100
            reshapeView.slider.value = filter.eyelidDown_delta
        } else if type == 112 {//瘦鼻 参数范围：0 - 100
            reshapeView.slider.value = filter.noseThin_delta
        } else if type == 113 {//鼻翼 参数范围：0 - 100
            reshapeView.slider.value = filter.noseWing_delta
        } else if type == 114 {//长鼻 参数范围：-50 - 50
            reshapeView.slider.value = filter.noseLong_delta
        } else if type == 115 {//鼻子山根 参数范围：0 - 100
            reshapeView.slider.value = filter.noseRoot_delta
        } else if type == 116 {//眉间距 参数范围：-50 - 50
            reshapeView.slider.value = filter.eyebrowDistance_delta
        } else if type == 117 {//眉粗细 参数范围：-50 - 50
            reshapeView.slider.value = filter.eyebrowThin_delta
        } else if type == 118 {//嘴型 参数范围：-50 - 50
            reshapeView.slider.value = filter.mouth_delta
        }
        reshapeView.valueLabel.text = String(format: "%.1f", reshapeView.slider.value)
    }
    
    func getReshapeDeltaValue(value: Float, type: Int) {
        if type == 100 {//小头 参数范围：0 - 100
            filter.headReduce_delta = value
        } else if type == 101 {//瘦脸 参数范围：0 - 100
            filter.faceThin_delta = value
        } else if type == 102 {//窄脸 参数范围：0 - 100
            filter.faceNarrow_delta = value
        } else if type == 103 {//V脸 参数范围：0 - 100
            filter.faceV_delta = value
        } else if type == 104 {//小脸 参数范围：0 - 100
            filter.faceSmall_delta = value
        } else if type == 105 {//下巴 参数范围：-50 - 50
            filter.chin_delta = value
        } else if type == 106 {//额头 参数范围：-50 - 50
            filter.forehead_delta = value
        } else if type == 107 {//颧骨 参数范围：-50 - 50
            filter.cheekbone_delta = value
        } else if type == 108 {//大眼 参数范围：0 - 100
            filter.eyeBig_delta = value
        } else if type == 109 {//眼距 参数范围：-50 - 50
            filter.eyeDistance_delta = value
        } else if type == 110 {//眼角 参数范围：0 - 100
            filter.eyeCorner_delta = value
        } else if type == 111 {//下眼睑 0 - 100
            filter.eyelidDown_delta = value
        } else if type == 112 {//瘦鼻 参数范围：0 - 100
            filter.noseThin_delta = value
        } else if type == 113 {//鼻翼 参数范围：0 - 100
            filter.noseWing_delta = value
        } else if type == 114 {//长鼻 参数范围：-50 - 50
            filter.noseLong_delta = value
        } else if type == 115 {//鼻子山根 参数范围：0 - 100
            filter.noseRoot_delta = value
        } else if type == 116 {//眉间距 参数范围：-50 - 50
            filter.eyebrowDistance_delta = value
        } else if type == 117 {//眉粗细 参数范围：-50 - 50
            filter.eyebrowThin_delta = value
        } else if type == 118 {//嘴型 参数范围：-50 - 50
            filter.mouth_delta = value
        }
    }
    
    //MARK: Beauty Delegate
    func changeBeautyType(type: Int) {
        if type == 100 {//美白 参数范围：0 - 100
            beautyView.slider.value = filter.white_delta
        } else if type == 101 {//磨皮 参数范围 0 - 100
            beautyView.slider.value = filter.skin_delta
        } else if type == 102 {//亮眼 参数范围 0 - 100
            beautyView.slider.value = filter.eyeBright_delta
        } else if type == 103 {//白牙 参数范围 0 - 100
            beautyView.slider.value = filter.teethBright_delta
        }
        beautyView.valueLabel.text = String(format: "%.1f", beautyView.slider.value)
    }
    
    func getBeautyDeltaValue(value: Float, type: Int) {
        if type == 100 {//美白 参数范围：0 - 100
            filter.white_delta = value
        } else if type == 101 {//磨皮 参数范围 0 - 100
            filter.skin_delta = value
        } else if type == 102 {//亮眼 参数范围 0 - 100
            filter.eyeBright_delta = value
        } else if type == 103 {//白牙 参数范围 0 - 100
            filter.teethBright_delta = value
        }
    }
    
    //MARK: Makeup Delegate
    func changeMakeupType(type: Int) {
        var makeupString = ""
        if type == 0 {//眉毛 参数范围 0 - 100
            if eyebrowType.contains(filter.makeup_eyebrow_type) {
                let index = eyebrowType.firstIndex(of: filter.makeup_eyebrow_type)!
                makeupString = eyebrowString[index]
            }
            makeupView.value = filter.makeup_eyebrow_delta
        } else if type == 1 {//眼影 参数范围 0 - 100
            if eyeshadowType.contains(filter.makeup_eyeshadow_type) {
                let index = eyeshadowType.firstIndex(of: filter.makeup_eyeshadow_type)!
                makeupString = eyeshadowString[index]
            }
            makeupView.value = filter.makeup_eyeshadow_delta
        } else if type == 2 {//美瞳 参数范围 0 - 100
            if pupilType.contains(filter.makeup_pupil_type) {
                let index = pupilType.firstIndex(of: filter.makeup_pupil_type)!
                makeupString = pupilString[index]
            }
            makeupView.value = filter.makeup_pupil_delta
        } else if type == 3 {//腮红 参数范围 0 - 100
            if blushType.contains(filter.makeup_blush_type) {
                let index = blushType.firstIndex(of: filter.makeup_blush_type)!
                makeupString = blushString[index]
            }
            makeupView.value = filter.makeup_blush_delta
        } else if type == 4 {//口红 参数范围 0 - 100
            if rougeType.contains(filter.makeup_rouge_type) {
                let index = rougeType.firstIndex(of: filter.makeup_rouge_type)!
                makeupString = rougeString[index]
            }
            makeupView.value = filter.makeup_rouge_delta
        }
        makeupView.makeupString = makeupString
    }
    
    func getMakeupDeltaValue(value: Float, makeupType: Int, makeupString: String) {
        if makeupType == 0 {//眉毛 参数范围：0 - 100
            filter.makeup_eyebrow_delta = value
            filter.makeup_eyebrow_type = changeEyebrowStringToMakeupType(name: makeupString)
        } else if makeupType == 1 {//眼妆 参数范围：0 - 100
            filter.makeup_eyeshadow_delta = value
            filter.makeup_eyeshadow_type = changeEyeshadowStringToMakeupType(name: makeupString)
        } else if makeupType == 2 {//美瞳 参数范围：0 - 100
            filter.makeup_pupil_delta = value
            filter.makeup_pupil_type = changePupilStringToMakeupType(name: makeupString)
        } else if makeupType == 3 {//腮红 参数范围：0 - 100
            filter.makeup_blush_delta = value
            filter.makeup_blush_type = changeBlushStringToMakeupType(name: makeupString)
        } else if makeupType == 4 {//口红 参数范围：0 - 100
            filter.makeup_rouge_delta = value
            filter.makeup_rouge_type = changeRougeStringToMakeupType(name: makeupString)
        }
    }
    
    //MARK: Action
    @objc func closeAction() {
        dismiss(animated: true)
    }
    
    @objc func changeAction() {
        isFront = !isFront
        camera.changeInputDeviceisFront(isFront)
    }
    
    @objc func itemButtonAction(button:UIButton) {
        currentShow = button.tag
    }
    
    //MARK: Private Method
    ///将字符串(图片名)转换为对应的美妆眉毛Type
    private func changeEyebrowStringToMakeupType(name: String) -> MakeupEyebrowType {
        
        if eyebrowString.contains(name) {
            let index = eyebrowString.firstIndex(of: name)!
            return eyebrowType[index]
        }
        return .eyebrow_none
    }
    ///将字符串(图片名)转换为对应的美妆眼妆Type
    private func changeEyeshadowStringToMakeupType(name: String) -> MakeupEyeshadowType {
        if eyeshadowString.contains(name) {
            let index = eyeshadowString.firstIndex(of: name)!
            return eyeshadowType[index]
        }
        return .eyeshadow_none
    }
    ///将字符串(图片名)转换为对应的美妆美瞳Type
    private func changePupilStringToMakeupType(name: String) -> MakeupPupilType {
        if pupilString.contains(name) {
            let index = pupilString.firstIndex(of: name)!
            return pupilType[index]
        }
        return .pupil_none
    }
    ///将字符串(图片名)转换为对应的美妆腮红Type
    private func changeBlushStringToMakeupType(name: String) -> MakeupBlushType {
        if blushString.contains(name) {
            let index = blushString.firstIndex(of: name)!
            return blushType[index]
        }
        return .blush_none
    }
    ///将字符串(图片名)转换为对应的美妆口红Type
    private func changeRougeStringToMakeupType(name: String) -> MakeupRougeType {
        if rougeString.contains(name) {
            let index = rougeString.firstIndex(of: name)!
            return rougeType[index]
        }
        return .rouge_none
    }

    ///将美妆眉毛Type转换为对应的字符串(图片名)
    private func changeMakeupTypeToEyebrowString(makeupType: MakeupEyebrowType) -> String {
        if eyebrowType.contains(makeupType) {
            let index = eyebrowType.firstIndex(of: makeupType)!
            return eyebrowString[index]
        }
        return ""
    }
    ///将美妆眼妆Type转换为对应的字符串(图片名)
    private func changeMakeupTypeToEyeshadowString(makeupType: MakeupEyeshadowType) -> String {
        if eyeshadowType.contains(makeupType) {
            let index = eyeshadowType.firstIndex(of: makeupType)!
            return eyeshadowString[index]
        }
        return ""
    }
    ///将美妆美瞳Type转换为对应的字符串(图片名)
    private func changeMakeupTypeToPupilString(makeupType: MakeupPupilType) -> String {
        if pupilType.contains(makeupType) {
            let index = pupilType.firstIndex(of: makeupType)!
            return pupilString[index]
        }
        return ""
    }
    ///将美妆腮红Type转换为对应的字符串(图片名)
    private func changeMakeupTypeToBlushString(makeupType: MakeupBlushType) -> String {
        if blushType.contains(makeupType) {
            let index = blushType.firstIndex(of: makeupType)!
            return blushString[index]
        }
        return ""
    }
    ///将美妆口红Type转换为对应的字符串(图片名)
    private func changeMakeupTypeToRougeString(makeupType: MakeupRougeType) -> String {
        if rougeType.contains(makeupType) {
            let index = rougeType.firstIndex(of: makeupType)!
            return rougeString[index]
        }
        return ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
