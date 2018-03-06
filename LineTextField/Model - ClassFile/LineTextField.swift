//
//  LineTextField.swift
//  LineTextField
//
//  Created by Teja on 3/6/18.
//  Copyright © 2018 Teja. All rights reserved.
//

import UIKit

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
    private var lineColor:UIColor = .black
    //LineWidth
    private var lineWidth:CGFloat = 2{
        didSet{
            self.setNeedsDisplay()
            if isFirstResponder{
                self.lineColor = activeLineColor
            }else{
                self.lineColor = inactiveLineColor
            }
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
        self.lineWidth = 4
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.lineWidth = 2
    }
    
    override func draw(_ rect: CGRect)
    {
        delegate = self
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.maxY))
        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        path.close()
        path.lineWidth = self.lineWidth
        lineColor.setStroke()
        path.stroke()
    }
    
}
