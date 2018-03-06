//
//  LineTextField.swift
//  LineTextField
//
//  Created by Teja on 3/6/18.
//  Copyright © 2018 Teja. All rights reserved.
//

import UIKit

@IBDesignable
class LineTextField: UITextField,UITextFieldDelegate {
    
    //Active Line Color
    @IBInspectable var activeLineColor:UIColor = .green {
        didSet{
        }
    }
    //Inactive line Color
    @IBInspectable var inactiveLineColor:UIColor = .black {
        didSet{
            self.lineColor = inactiveLineColor
        }
    }
    //Top Label
    var topLabel:UILabel = UILabel()
    
    private var lineColor:UIColor = .black
    //LineWidth
    private var lineWidth:CGFloat = 2{
        didSet{
            if isFirstResponder{
                self.lineColor = activeLineColor
            }else{
                self.lineColor = inactiveLineColor
            }
            self.setNeedsDisplay()
        }
    }
    
    //LeftImage
    @IBInspectable var leftViewImage:UIImage? {
        didSet{
            updateLeftImage()
        }
    }
    @IBInspectable var imagePadding:CGFloat = 0{
        didSet{
            updateLeftImage()
        }
    }
    
    private let path = UIBezierPath()
    
    func updateLeftImage(){
        
        if let image = leftViewImage{
            self.leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: self.imagePadding/2, y: 0.15 * (self.bounds.height), width: self.bounds.height - 0.30 * (self.bounds.height), height: self.bounds.height - 0.30 * (self.bounds.height)))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            let textLeftView = UIView(frame: CGRect(x: 0, y: 0, width: imagePadding+imageView.bounds.width, height: self.bounds.height))
            textLeftView.addSubview(imageView)
            self.leftView = textLeftView
        }else{
            self.leftViewMode = .never
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        topLabel.frame = CGRect(x: 0, y: self.bounds.minY - 40, width: self.bounds.width, height: 40)
        topLabel.text = self.placeholder
        if self.text == "" {
            self.topLabel.alpha = 0.0
            self.addSubview(topLabel)
        }
        UIView.animate(withDuration: 0.5) {
            self.topLabel.alpha = 1.0
        }
        self.lineWidth = 4
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.lineWidth = 2
        if self.text == "" {
            topLabel.removeFromSuperview()
        }
        
    }
    
    override func draw(_ rect: CGRect)
    {
        delegate = self
            self.path.move(to: CGPoint(x: 0, y: self.bounds.maxY))
            self.path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
            self.path.close()
            self.path.lineWidth = self.lineWidth
            lineColor.setStroke()
            self.path.stroke()
    }
    
}
