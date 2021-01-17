//
//  LLJZoomScrollView.swift
//  TakePhoto
//
//  Created by EtekCity-刘廉俊 on 2020/11/26.
//

import UIKit

class LLJZoomScrollView: UIScrollView, UIScrollViewDelegate {
    
    lazy var sWidth = self.frame.size.width
    lazy var sHeight = self.frame.size.height
    
    lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        self.insertSubview(imageV, at: 0)
        return imageV
    }()
    
    var lastOffset : CGPoint?
    
    var image : UIImage? {
        willSet {
            self.imageView.image = newValue
            let rate = newValue!.size.width / newValue!.size.height
            let height = sWidth / rate
            if (rate >= 1.0) {
                self.imageView.frame = CGRect.init(x: 0, y: (sHeight - height) / 2.0, width: sWidth, height: height)
                self.contentSize = CGSize.init(width: sWidth, height: sHeight)
                self.setContentOffset(CGPoint.zero, animated: false)
            } else {
                self.contentSize = CGSize.init(width: sWidth, height: height - sWidth + sHeight)
                self.imageView.frame = CGRect.init(x: 0, y: (self.contentSize.height - height) / 2.0, width: sWidth, height: height)
                self.setContentOffset(CGPoint.init(x: 0, y: (height - sWidth) / 2.0), animated: false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = .clear
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.maximumZoomScale = 3
        self.minimumZoomScale = 1
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewFrame = self.imageView.frame
        let width = imageViewFrame.size.width
        let height = imageViewFrame.size.height
        
        let horizontalPadding : CGFloat = width < sWidth ? (sWidth - width) / 2.0 : 0.0;
        let verticalPadding : CGFloat = height > sHeight ? abs((sHeight - height) / 2.0) : 0.0;
//        let verticalPadding : CGFloat = (sHeight - sWidth) / 4.0;
        
        if (height < sWidth) {
            self.contentSize = CGSize.init(width: width, height: sHeight)
            self.imageView.frame = CGRect.init(x: 0, y: (sHeight - height) / 2.0, width: width, height: height)
        } else {
            self.contentSize = CGSize.init(width: width, height: height - sWidth + sHeight)
            self.imageView.frame = CGRect.init(x: 0, y: (sHeight - sWidth) / 2.0, width: width, height: height)
        }
        self.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
