//
//  GLKPreviewView.swift
//  提词器
//
//  Created by S weet on 2023/4/8.
//

import UIKit
import GLKit

class GLKPreviewView: UIView, GLKViewDelegate {
    
    private var glkView: GLKView!
    private var imageContext: CIContext!
    
    private var renderImg: CIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        glkView.frame = bounds
    }
    
    //MARK: UI
    func setupView() {
        let context = EAGLContext(api: .openGLES2)
        
        glkView = GLKView(frame: .zero)
        addSubview(glkView)
        glkView.delegate = self
        glkView.context = context!
        glkView.bindDrawable()
//        glkView.enableSetNeedsDisplay = false
        
        EAGLContext.setCurrent(context)
        
        imageContext = CIContext(eaglContext: context!)
    }
    
    //MARK: GLK View Delegate
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        if renderImg != nil {
            imageContext.draw(renderImg!, in: CGRect(x: 0, y: 0, width: glkView.drawableWidth, height: glkView.drawableHeight), from: renderImg!.extent)
        }
    }
    
    //MARK: Public Method
    func display(pixelBuffer: CVPixelBuffer) {
        let image = CIImage(cvPixelBuffer: pixelBuffer)
        self.renderImg = image
        glkView.display()
    }
}
