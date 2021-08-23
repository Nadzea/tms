//
//  CustomButtonMainView.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 17.08.21.
//

import UIKit

protocol CustomButtonMainViewDelegate: AnyObject {
    func buttonDidTap(_ sender: CustomButtonMainView)
}

@IBDesignable
class CustomButtonMainView: UIView {
    
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBOutlet var conteinerView: UIView!
    
    @IBInspectable var text: String {
        set { self.buttonLabel.text = newValue }
        get { return self.buttonLabel.text ?? "" }
    }
    
    @IBInspectable var textColor: UIColor {
        set { self.buttonLabel.textColor = newValue }
        get { return self.buttonLabel.textColor  }
    }
    
    @IBInspectable var font: UIFont {
        set { self.font = newValue }
        get { return self.font  }
    }
    
    @IBInspectable var image: UIImage {
        set { self.buttonImage.image = newValue }
        get { return self.buttonImage.image! }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { self.layer.borderColor = newValue.cgColor }
        get {
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            
            return .clear
        }
    }
    @IBInspectable override var backgroundColor: UIColor? {
        set { self.layer.backgroundColor = newValue?.cgColor}
        get { if let cgColor = self.layer.backgroundColor {
                return UIColor(cgColor: cgColor)
            }

            return .clear
        }
    }
    weak var delegate: CustomButtonMainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle(for: CustomButtonMainView.self).loadNibNamed("CustomButtonMainView", owner: self, options: nil)
        conteinerView.frame = self.bounds
        self.addSubview(conteinerView)
    }
    
    private func createAnimation() {
        UIView.animate(withDuration: 0) {
            self.conteinerView.transform = self.conteinerView.transform.scaledBy(x: 0.8, y: 0.8)
        }
        UIView.animate(withDuration: 0.3) {
            self.conteinerView.transform = .identity
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        createAnimation()
        delegate?.buttonDidTap(self)
    }
}
