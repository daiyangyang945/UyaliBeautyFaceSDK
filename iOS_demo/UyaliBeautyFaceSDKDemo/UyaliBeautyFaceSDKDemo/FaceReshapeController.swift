//
//  FaceReshapeController.swift
//  UyaliBeautyFaceSDKDemo
//
//  Created by S weet on 2023/1/27.
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

class FaceReshapeController: UIViewController,PFCameraDelegate,FaceReshapeDelegate {
    
    
    private var camera: PFCamera!
    private var openGLView: PFOpenGLView!
    
    private var beautyView : UIView!
    private var reshapeView : FaceReshapeView!
    
    private let filter = UyaliBeautyFaceFilter()
    
    private var isFront = true
    private var isReshapeShow = false

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
        
        beautyView = UIView(frame: CGRect(x: 0, y: kScreenHeight-50.0-bottomHeight, width: kScreenWidth, height: 50.0+bottomHeight))
        view.addSubview(beautyView)
        beautyView.backgroundColor = .black.withAlphaComponent(0.4)
        
        let reshapeButton = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50.0))
        beautyView.addSubview(reshapeButton)
        reshapeButton.setTitle("美型", for: .normal)
        reshapeButton.setTitleColor(.white, for: .normal)
        reshapeButton.addTarget(self, action: #selector(reshapeButtonAction), for: .touchUpInside)
        
        //Reshape View
        reshapeView = FaceReshapeView(frame: CGRect(x: 0, y: beautyView.frame.origin.y, width: kScreenWidth, height: 130.0))
        view.addSubview(reshapeView)
        reshapeView.alpha = 0
        reshapeView.isHidden = true
        reshapeView.delegate = self
        
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
        let outputPixelBuffer = filter.reshape(pixelBuffer: pixelBuffer!)
        openGLView.display(outputPixelBuffer)
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
    
    func getDeltaValue(value: Float, type: Int) {
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
    
    //MARK: Action
    @objc func closeAction() {
        dismiss(animated: true)
    }
    
    @objc func changeAction() {
        isFront = !isFront
        camera.changeInputDeviceisFront(isFront)
    }
    
    @objc func reshapeButtonAction() {
        isReshapeShow = !isReshapeShow
        if isReshapeShow {
            reshapeView.isHidden = false
            UIView.animate(withDuration: 0.15) {[self] in
                reshapeView.frame = CGRect(x: 0, y: reshapeView.frame.origin.y-reshapeView.frame.height, width: reshapeView.frame.width, height: reshapeView.frame.height)
                reshapeView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.15) {[self] in
                reshapeView.frame = CGRect(x: 0, y: beautyView.frame.origin.y, width: reshapeView.frame.width, height: reshapeView.frame.height)
                reshapeView.alpha = 0
            } completion: {[self] finished in
                reshapeView.isHidden = true
            }
        }
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
