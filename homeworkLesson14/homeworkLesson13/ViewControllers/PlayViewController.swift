//
//  PlayViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit
enum Checkers: Int {
    case white = 0
    case black = 1
}

class PlayViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var gameTime: UILabel!
    @IBOutlet var viewsForButton: [UIView]!
    @IBOutlet weak var backPlayScreen: UIView!
    
    var chessboard: UIView!
    var timer: Timer?
    var countSecond: Int = 0
    var countMinute: Int = 0
    var currentChecker: Checkers = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 0.729887431, blue: 0.9804635278, alpha: 1))
        backPlayScreen.addGradient(with: #colorLiteral(red: 1, green: 0.729887431, blue: 0.9804635278, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        
        viewsForButton.forEach { views in
            views.layer.cornerRadius = views.frame.height / 2
        }

        //backPlayScreen.addShadow(with: .red, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        
        gameTime.attributedText = NSAttributedString(string: gameTime.text!,
                                                     attributes: [
                                                    .foregroundColor : UIColor.purple,
                                                    .strokeColor : UIColor.blue,
                                                    .strokeWidth : -3,
                                                    .font: UIFont(name: "StyleScript-Regular", size: 36)!])
        
        timerLabel.attributedText = NSAttributedString(string: timerLabel.text!,
                                                       attributes: [
                                                       .foregroundColor : UIColor.darkGray,
                                                       .strokeColor : UIColor.black,
                                                       .strokeWidth : -3,
                                                       .font: UIFont(name: "StyleScript-Regular", size: 36)!])
        
        createChessboard()
        
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        timerLabel.text = "0\(countMinute):0\(countSecond)"
    }
    
    func createChessboard() {
        chessboard = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.size.width, height: view.bounds.size.width)))
        chessboard.backgroundColor = .brown
        let sizeCell = view.bounds.size.width / 8
        
        for row in 0..<8 {
            for column in 0..<8 {
                let cell = UIView(frame: CGRect(x: sizeCell * CGFloat(column),
                                                y: sizeCell * CGFloat(row),
                                                width: sizeCell,
                                                height: sizeCell))
                cell.backgroundColor = ((row + column) % 2) == 0 ? .white : .black
                chessboard.addSubview(cell)
                
                guard row < 3 || row > 4, cell.backgroundColor == .black else { continue }
                
                let checkerImage = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCell - 10, height: sizeCell - 10))
                checkerImage.image = UIImage(named: row < 3 ? "whiteChecker" : "blackChecker")
                checkerImage.tag = row < 3 ? 0 : 1
                cell.addSubview(checkerImage)
                checkerImage.isUserInteractionEnabled = true //чтобы картинка реагировала на жесты
                
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer(_:)))
                longPressGesture.minimumPressDuration = 0.1
                longPressGesture.delegate = self
                checkerImage.addGestureRecognizer(longPressGesture)
                
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
                panGesture.delegate = self
                checkerImage.addGestureRecognizer(panGesture)
                
            }
        }
        view.addSubview(chessboard)
        chessboard.center = view.center
    }
    
    @IBAction func backPlayScreen(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        dismiss(animated: true, completion: nil)
    }
    
    @objc func timerFunc() {
        countSecond += 1
        if countSecond > 59 {
            countMinute += 1
            countSecond = 0
        }
        timerLabel.text = countSecond < 10 ? "0\(countMinute):0\(countSecond)" : "0\(countMinute):\(countSecond)"
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        
        guard let checker = sender.view else { return }
        
        switch sender.state {
        case .began:
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = checker.transform.scaledBy(x: 1.3, y: 1.3)
            }
            
        case .ended:
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = .identity
            }
            
        default: break
        }
        
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        
        guard sender.view?.tag == currentChecker.rawValue else { return }
        
        let location = sender.location(in: chessboard) // координата где находится курсор относительно доски
        let translation = sender.translation(in: chessboard)
        
        switch sender.state {
        
        case .changed:
            
            guard let cell = sender.view?.superview, let cellOrigin = sender.view?.frame.origin else {return}//sender.view распознаватель жестов для объекта, view - это объекты, на которые добавляли жест. sender.view?.superview это клетка, на которой стоит шашка, которую пользователь выбрал для движения, sender.view?.frame.origin координата от которой начинаем движение
            
            chessboard.bringSubviewToFront(cell)

            sender.view?.frame.origin = CGPoint(x: cellOrigin.x + translation.x,
                                                y: cellOrigin.y + translation.y)
            sender.setTranslation(.zero, in: chessboard) //сбрасываем translation
        
        case .ended:
            
            UIView.animate(withDuration: 0.3) {
                sender.view!.transform = .identity
            }
            
            var currentCell: UIView? = nil //клетка на которой заканчивается движение
            
            chessboard.subviews.forEach { cell in
                if cell.frame.contains(location), cell.backgroundColor == .black {
                    currentCell = cell
                    return
                }
            }
            
            sender.view?.frame.origin = CGPoint(x: 5, y: 5)
            guard let newCell = currentCell, newCell.subviews.isEmpty, let checker = sender.view else {
                return
            }
            
            currentCell?.addSubview(checker)
            
            if currentChecker == .white {
                currentChecker = .black
            } else {
                currentChecker = .white
            }
            
        default: break
        }
    }
}
extension UIViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
    }
} //чтобы два жеста были к одному объекту необходимо использовать делегат
