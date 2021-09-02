//
//  CustomButton.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.08.21.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func buttonDidTap(_ sender: CustomButton)
}

@IBDesignable //чтобы можно было использовать кнопку в сториборде
class CustomButton: UIView {
    
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet var conteinerView: UIView!
    
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
    
    @IBInspectable var isAnimated: Bool = false //если не нужна анимация для кнопки, то можно поставить галочку в сторибоде, по умолчанию стоит true
        
    weak var delegate: CustomButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createAnimationIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle(for: CustomButton.self).loadNibNamed("CustomButton", owner: self, options: nil) //bundle дерево проекта. то есть в дереве проекта ищем наш класс и загружаем
        conteinerView.frame = self.bounds //инициализируем размер
        self.addSubview(conteinerView)
        
    }
    
    private func createAnimationIfNeeded() {
        guard isAnimated else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.conteinerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        delegate?.buttonDidTap(self)
    }
}
