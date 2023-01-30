//
//  ViewController.swift
//  UyaliBeautyFaceSDKDemo
//
//  Created by S weet on 2023/1/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button1 = UIButton(frame: CGRect(x: view.bounds.width/2-50, y: view.bounds.height/2-100, width: 100, height: 50))
        view.addSubview(button1)
        button1.setTitle("美型滤镜", for: .normal)
        button1.setTitleColor(UIColor(named: "color_text"), for: .normal)
        button1.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
    }

    @objc func buttonAction1() {
        let controller = FaceReshapeController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }


}

