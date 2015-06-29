//
//  NGOPassCodeView.swift
//  andGo
//
//  Created by Stanislav Zhukovskiy on 29.06.15.
//  Copyright (c) 2015 Stas Zhukovskiy. All rights reserved.
//

import Foundation

public protocol NGOPassCodeViewDelegate {
    func NGOPassCodeViewDidFinishEnteringPassword(password: String)
}

public class NGOPassCodeView: UIView, UITextFieldDelegate {
    
    public var delegate: NGOPassCodeViewDelegate?
    public var borderColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.setupScrollView()
        }
    }
    public var borderWidth: CGFloat = 1 {
        didSet {
            self.setupScrollView()
        }
    }
    public var numberOfDigits: Int = 6 {
        didSet {
            self.setupScrollView()
        }
    }
    public var circleDiameter: CGFloat = 24 {
        didSet {
            self.setupScrollView()
        }
    }
    public var keyboardAppearance: UIKeyboardAppearance = UIKeyboardAppearance.Dark {
        didSet {
            self.setupTextField()
        }
    }
    
    private var scrollView: UIScrollView = UIScrollView()
    private var textField: UITextField = UITextField()
    
    //MARK: - View Cycle
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView = UIScrollView(frame: self.bounds)
        self.setupScrollView()
        self.addSubview(self.scrollView)
        
        self.textField = UITextField(frame: self.bounds)
        self.setupTextField()
        self.addSubview(self.textField)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupScrollView()
    }
    
    //MARK: - Setup UI
    
    private func setupScrollView() {
        self.scrollView.subviews.map{ $0.removeFromSuperview() }
        
        let viewWidth       = CGRectGetWidth(self.frame) / CGFloat(self.numberOfDigits)
        let passCharacters  = count(self.textField.text)
        
        for (index, element) in enumerate(0...self.numberOfDigits - 1) {
            
            let frame   = CGRectMake(CGFloat(index) * viewWidth, 0, viewWidth, CGRectGetHeight(self.bounds))
            var view    = UIView(frame: frame)
            view.backgroundColor = UIColor.clearColor()
            
            if index < passCharacters {
                view.layer.addSublayer(self.circleInFrame(frame, isFilled: true))
            }
            else {
                view.layer.addSublayer(self.circleInFrame(frame, isFilled: false))
            }
            self.scrollView.addSubview(view)
        }
    }
    
    private func setupTextField() {
        self.textField.delegate             = self
        self.textField.textColor            = UIColor.clearColor()
        self.textField.tintColor            = UIColor.clearColor()
        self.textField.keyboardType         = UIKeyboardType.NumberPad
        self.textField.keyboardAppearance   = self.keyboardAppearance
    }
    
    private func circleInFrame(outerFrame: CGRect, isFilled filled: Bool) -> CAShapeLayer {
        var innerFrame      = CGRectZero
        innerFrame.origin.x = (outerFrame.size.width / 2) - (self.circleDiameter / 2)
        innerFrame.origin.y = (outerFrame.size.height / 2) - (self.circleDiameter / 2)
        innerFrame.size     = CGSizeMake(self.circleDiameter, self.circleDiameter)
        
        var circle          = CAShapeLayer()
        circle.path         = UIBezierPath(roundedRect: innerFrame, cornerRadius: self.circleDiameter / 2).CGPath
        circle.fillColor    = filled ?  self.borderColor.CGColor : UIColor.clearColor().CGColor
        circle.strokeColor  = self.borderColor.CGColor
        circle.lineWidth    = self.borderWidth
        return circle
    }
    
    //MARK: - TextField Delegate
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let length = count(textField.text)
        if count(string) == 0 {
            if length == 0 {
                return false
            }
        }
        else {
            if length == self.numberOfDigits - 1 {
                textField.text = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
                self.setupScrollView()
                self.delegate?.NGOPassCodeViewDidFinishEnteringPassword(self.textField.text)
                return false
            }
            else if length > self.numberOfDigits - 1 {
                return false
            }
        }
        textField.text = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        self.setupScrollView()
        return false
    }
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.textField.text = ""
        self.setupScrollView()
        return true
    }
    
    public override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: false)
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    //MARK: - Delegate functions
    
    public func reset() {
        self.textField.text = ""
        self.setupScrollView()
    }
    
    public func shouldBecomeFirstResponder() {
        self.textField.becomeFirstResponder()
    }
    
    public func shouldResignFirstResponder() {
        self.textField.resignFirstResponder()
    }
}