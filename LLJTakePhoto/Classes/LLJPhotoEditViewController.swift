//
//  LLJPhotoEditViewController.swift
//  TakePhoto
//
//  Created by EtekCity-刘廉俊 on 2020/11/26.
//

import UIKit

public class LLJPhotoEditViewController: UIViewController, UIScrollViewDelegate {
    
    let UIScreenWidth = UIScreen.main.bounds.size.width
    let UIScreenHeight = UIScreen.main.bounds.size.height
    let ButtonWidth : CGFloat = 90
    let ButtonHeight : CGFloat = 60
    
    var image : UIImage?
    
    var captureImage: UIImage? {
        var image: UIImage? = nil
        let frame = UIScreen.main.bounds
        UIGraphicsBeginImageContext(frame.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageRef = image?.cgImage?.cropping(to: CGRect.init(x: 0, y: (UIScreenHeight - UIScreenWidth) / 2.0, width: frame.size.width, height: frame.size.width))
        /// 返回尺寸为200 * 200 的图片
        image = UIImage.init(cgImage: imageRef!, scale: UIScreenWidth / 200, orientation: .up)
        return image
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black;
        let view = LLJZoomScrollView.init(frame: self.view.bounds)
        view.image = self.image
        self.view.addSubview(view)
        
        let titleArr : [String] = ["Cancel","Save"]
        for i in 0..<titleArr.count {
            let space = (UIScreenHeight - UIScreenWidth) / 2.0
            let tmpV : UIView = UIView.init(frame: CGRect.init(x: 0, y: CGFloat(i) * (space + UIScreenWidth), width: UIScreenWidth, height: space))
            tmpV.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.insertSubview(tmpV, aboveSubview: view)
            
            var safeBottom : CGFloat = 0.0
            if #available(iOS 11.0, *) {
                safeBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            }
            let tmpB = UIButton.init(type: .custom);
            tmpB.tag = i;
            tmpB.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
            tmpB.frame = CGRect.init(x: (UIScreenWidth - ButtonWidth) * CGFloat(i), y: UIScreenHeight - safeBottom - ButtonHeight, width: ButtonWidth, height: ButtonHeight);
            tmpB.setTitle(titleArr[i], for: .normal)
            self.view.addSubview(tmpB);
        }
    }
    
    @objc func click(_ sender:UIButton) -> Void {
        if sender.tag == 0 {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hhhh"), object: captureImage)
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
