//
//  ZBAlertBox.swift
//  BSYAlertBoxDemo
//
//  Created by mqt on 2018/5/31.
//  Copyright © 2018年 mqt. All rights reserved.
//

import UIKit

enum TranglePositinType {
    case left
    case right
    case center
}


class ZBAlertView: UIView {

    // 底部背景
    lazy var bglayer:CAShapeLayer = {
       let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.black.cgColor
        return layer
    }()
    
    /// 三角形
    lazy var triangleLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.black.cgColor
        return layer
    }()
    
    /// 提示语
    lazy var hintLabel:UILabel = {
       let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = self.font
        label.backgroundColor = UIColor.clear
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
//        label.minimumScaleFactor = 0.6
        return label
    }()
    
    /// 背景颜色
    var bgColor:UIColor = UIColor.black
    
    /// 字体大小
    var font:UIFont = UIFont.systemFont(ofSize: 12)
    
    /// 字体颜色
    var textColor:UIColor = UIColor.white
    
    /// 三角形的大小
    var trangleW:CGFloat = 20
    var trangleH:CGFloat = 10
    
    /// 提示语
    var  showString:String = ""
    
    /// 圆形角度
    var cornerRadius:CGFloat = 5
    
    /// 三角形位置
    var tranglePositionType = TranglePositinType.center
    
    convenience init(view: UIView,
                     showString:String,
                     font:UIFont = UIFont.systemFont(ofSize: 18),
                     textColor:UIColor = UIColor.white,
                     bgColor:UIColor = UIColor.black,
                     cornerRadius:CGFloat = 5,
                     tranglePositionType:TranglePositinType = .center) {
        self.init(frame: CGRect.zero)
//        let text = showString as NSString
        
        let textSize = self.textSize(text: showString, font: font, maxSize: CGSize(width: view.bounds.size.width + 20, height: view.bounds.size.height * 10))
        let point = view.convert(view.bounds.origin, to: UIApplication.shared.keyWindow?.rootViewController?.view)
        let frame = CGRect(x: point.x , y: point.y - textSize.height , width: textSize.width, height: textSize.height)
        self.frame = frame
        self.bgColor = bgColor
        self.textColor = textColor
        self.font = font
        self.showString = showString
        self.cornerRadius = cornerRadius
        self.tranglePositionType = tranglePositionType
//        self.setNeedsLayout()
        self.initData(frame: frame)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func initData(frame:CGRect){
        self.backgroundColor = UIColor.clear
        self.drawBg()
        // 添加提示语
        let labelFrame = CGRect(x: 4, y: 4, width: frame.size.width - 8, height: frame.size.height - self.trangleH - 8)
        self.hintLabel.frame = labelFrame
        self.hintLabel.text = self.showString
        self.hintLabel.font = self.font
        self.hintLabel.textColor = UIColor.white
        self.addSubview(self.hintLabel)
    }
    
    func drawBg(){
        // 背景
        let bglayer = CAShapeLayer()
        bglayer.backgroundColor = self.bgColor.cgColor
        bglayer.cornerRadius = self.cornerRadius
    
        let y = self.frame.size.height - self.trangleH
        
        let bgFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: y)
        bglayer.frame = bgFrame
        self.layer.addSublayer(bglayer)
        
        // 画三角形
        let tranLayer = CAShapeLayer()
        let gradienPath = UIBezierPath()
        if self.tranglePositionType == .left{
            gradienPath.move(to: CGPoint(x: 10, y: y))
            gradienPath.addLine(to: CGPoint(x: 10 + self.trangleW, y: y))
            gradienPath.addLine(to: CGPoint(x: 10 + self.trangleW / 2, y: y + self.trangleH))
            gradienPath.addLine(to: CGPoint(x: 10, y: y))
            tranLayer.path = gradienPath.cgPath
        }else if self.tranglePositionType == .center{
            gradienPath.move(to: CGPoint(x: self.frame.size.width / 2 - self.trangleW / 2, y: y))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width / 2 - self.trangleW / 2 + self.trangleW, y: y))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width / 2 - self.trangleW / 2 + self.trangleW / 2, y: y + self.trangleH))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width / 2 - self.trangleW / 2, y: y))
            tranLayer.path = gradienPath.cgPath
        }else{
            gradienPath.move(to: CGPoint(x: self.frame.size.width  - self.trangleW - 10, y: y))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width  - self.trangleW - 10 + self.trangleW, y: y))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width  - self.trangleW - 10 + self.trangleW / 2, y: y + self.trangleH))
            gradienPath.addLine(to: CGPoint(x: self.frame.size.width  - self.trangleW - 10, y: y))
            tranLayer.path = gradienPath.cgPath
        }
        
        
        self.layer.addSublayer(tranLayer)
        
    }
    
    /// 计算高度
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize {
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
    
    func show(duration:TimeInterval?){
        guard let window = UIApplication.shared.windows.last else{
            return
        }
        window.addSubview(self)
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(.easeIn)
        UIView.setAnimationDuration(0.5)
        self.alpha = 1
        UIView.commitAnimations()
        if let d = duration {
            self.perform(#selector(self.hiden), with: nil, afterDelay: d)
        }
        
    }
    
    
    
    @objc func hiden(){
        UIView.beginAnimations("hiden", context: nil)
        UIView.setAnimationCurve(.easeIn)
        UIView.setAnimationDuration(0.5)
        self.alpha = 0
        UIView.commitAnimations()
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
