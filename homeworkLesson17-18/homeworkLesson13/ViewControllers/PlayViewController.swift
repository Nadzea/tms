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
    
    @IBOutlet weak var timerSeconds: UILabel!
    @IBOutlet weak var timerMitutes: UILabel!
    @IBOutlet weak var gameTime: UILabel!
    @IBOutlet var viewsForButton: [UIView]!
    @IBOutlet weak var backPlayScreen: UIView!
    
    var chessboard: UIView!
    var timer: Timer?
    var countSecond: Int = 0
    var countMinute: Int = 0
    var currentChecker: Checkers = .white
    var savedCurrentChecker: Int = 0
    var savedCheckers: [Checker] = []
    
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 0.729887431, blue: 0.9804635278, alpha: 1))
        backPlayScreen.addGradient(with: #colorLiteral(red: 1, green: 0.729887431, blue: 0.9804635278, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        
        viewsForButton.forEach { views in
            views.layer.cornerRadius = views.frame.height / 2
        }
        
        gameTime.attributedText = NSAttributedString(string: gameTime.text!,
                                                     attributes: [
                                                    .foregroundColor : UIColor.purple,
                                                    .strokeColor : UIColor.blue,
                                                    .strokeWidth : -3,
                                                    .font: UIFont(name: "StyleScript-Regular", size: 36)!])
        
        timerSeconds.attributedText = NSAttributedString(string: timerSeconds.text!,
                                                       attributes: [
                                                       .foregroundColor : UIColor.darkGray,
                                                       .strokeColor : UIColor.black,
                                                       .strokeWidth : -3,
                                                       .font: UIFont(name: "StyleScript-Regular", size: 36)!])
        
        timerMitutes.attributedText = NSAttributedString(string: timerMitutes.text!,
                                                       attributes: [
                                                       .foregroundColor : UIColor.darkGray,
                                                       .strokeColor : UIColor.black,
                                                       .strokeWidth : -3,
                                                       .font: UIFont(name: "StyleScript-Regular", size: 36)!])

        
        
        createChessboard()
        
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    
    }
    
    func createChessboard() {
        chessboard = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.size.width, height: view.bounds.size.width)))
        chessboard.backgroundColor = .brown
        let sizeCell = view.bounds.size.width / 8
        var i = 0 //счетчик для тагов клетки
        for row in 0..<8 {
            for column in 0..<8 {
                let cell = UIView(frame: CGRect(x: sizeCell * CGFloat(column),
                                                y: sizeCell * CGFloat(row),
                                                width: sizeCell,
                                                height: sizeCell))
                
                cell.backgroundColor = ((row + column) % 2) == 0 ? .white : .black
                cell.tag = i
                
                chessboard.addSubview(cell)
                i += 1
                
                let checkerImage = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCell - 10, height: sizeCell - 10))

                let manager = FileManager.default
                if manager.fileExists(atPath: documentDirectory.appendingPathComponent("checkers").path) {
                    
                    applyDataFromUserDefaults()
                    timerMitutes.text = "0\(countMinute):"
                    timerSeconds.text = "0\(countSecond)"
                    currentChecker = savedCurrentChecker == 0 ? .white : .black
                    
                    getCheckers()
                    
                    savedCheckers.forEach { checker in
                        if checker.positionTag == cell.tag {
                            checkerImage.image = UIImage(named: checker.colorTag == 0 ? "style2WhiteChecker" : "style2BlackChecker")
                            checkerImage.tag = checker.colorTag == 0 ? 0 : 1
                            cell.addSubview(checkerImage)
                        }
                    }
                        } else {
                            
                            timerMitutes.text = "0\(countMinute):"
                            timerSeconds.text = "0\(countSecond)"
                            
                            guard row < 3 || row > 4, cell.backgroundColor == .black else { continue }
                                checkerImage.image = UIImage(named: row < 3 ? "style2WhiteChecker" : "style2BlackChecker")
                                checkerImage.tag = row < 3 ? 0 : 1
                                cell.addSubview(checkerImage)
                        }
                
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
    
    func saveDataToUserDefaults() { //функция для сохранения данных
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(self.countMinute, forKey: KeysUserDefaults.timerMinutes.rawValue)
        userDefaults.setValue(self.countSecond, forKey: KeysUserDefaults.timerSeconds.rawValue)
        userDefaults.setValue(self.currentChecker.rawValue, forKey: KeysUserDefaults.currentChecker.rawValue)
        
    }
    
    func applyDataFromUserDefaults() { //функция для получения сохраненных данных
        let userDefaults = UserDefaults.standard
        let minutes = (userDefaults.integer(forKey: KeysUserDefaults.timerMinutes.rawValue))
        self.countMinute = minutes
        let seconds = (userDefaults.integer(forKey: KeysUserDefaults.timerSeconds.rawValue))
        self.countSecond = seconds
        let savedCurrentChecker = (userDefaults.integer(forKey: KeysUserDefaults.currentChecker.rawValue))
        self.savedCurrentChecker = savedCurrentChecker
    }
    
    func saveCheckers() {
        chessboard.subviews.forEach { cell in
            if !cell.subviews.isEmpty {
                cell.subviews.forEach { checker in
                    let savedChecker = Checker(colorTag: checker.tag, positionTag: cell.tag)
                    savedCheckers.append(savedChecker)
                }
            }
        }
        
        let data = try? NSKeyedArchiver.archivedData(withRootObject: savedCheckers, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent("checkers")
        try? data?.write(to: fileURL)
    }
    
    func getCheckers() {
        let fileURL = documentDirectory.appendingPathComponent("checkers")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return }
        
        let newArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Checker]
        self.savedCheckers = newArray!
    }
    
    @IBAction func backPlayScreen(_ sender: Any) {
        
        presentAlertController(with: nil,
                               message: "Do you want to leave the game?",
                               actions: UIAlertAction(title: "Save and leave the game",
                               style: .default,
                               handler: { _ in
                                self.view.removeBlurView()
                                self.saveCheckers()
                                self.saveDataToUserDefaults()
                                self.dismiss(animated: true, completion: nil)}),
                                        UIAlertAction(title: "Leave the game",
                                                      style: .default,
                                                      handler: { _ in
                                                        self.dismiss(animated: true, completion: nil)}))
    }
    
    @objc func timerFunc() {
        countSecond += 1
        countMinute = countSecond / 60
        
        timerMitutes.text = countMinute < 10 ? "0\(countMinute):" : "\(countMinute):"
        timerSeconds.text = (countSecond % 60) < 10 ? "0\(countSecond % 60)" : "\(countSecond % 60)"
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
        
        guard let checker = sender.view,
              checker.tag == currentChecker.rawValue else { return }
        
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
            guard let newCell = currentCell, newCell.subviews.isEmpty, let checker = sender.view else {  return }

            newCell.addSubview(checker)

            currentChecker = currentChecker == .white ? .black : .white
            
        default: break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
        
    }
}
extension UIViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
    }
} //чтобы два жеста были к одному объекту необходимо использовать делегат
