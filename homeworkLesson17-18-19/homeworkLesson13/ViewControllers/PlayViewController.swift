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
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var imageForPlayScreen: UIImageView!
    
    var chessboard: UIView!
    var timer: Timer?
    var countSecond: Int = 0
    var countMinute: Int = 0
    var currentChecker: Checkers = .white
    var savedCurrentChecker: Int = 0
    var savedCheckers: [Checker] = []
    var styleOfChecker = StyleOfChecker(whiteChecker: "style1WhiteChecker",
                                         blackChecker: "style1BlackChecker",
                                         stateSwitch: true)
    var cellsForMove: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.delegate = self
        
        getSaveData()
        getStyleChecker()
        createChessboard()
        screenSettings()
        
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.timerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    func screenSettings() {
        self.view.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4803237184, green: 0.7373365856, blue: 0.8808781744, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        backButton.addShadow(with: .gray, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        timerView.addBorder(with: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), borderWidth: 3, cornerRadius: 10)
        
        gameTime.addAttributedText(with: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), foregroundColor: #colorLiteral(red: 0.7087161869, green: 0.993346738, blue: 1, alpha: 1), strokeWidth: -3, size: 46)
        timerSeconds.addAttributedText(with: .black, foregroundColor: .gray, strokeWidth: -3, size: 36)
        timerMitutes.addAttributedText(with: .black, foregroundColor: .gray, strokeWidth: -3, size: 36)
        chessboard.addShadow(with: .black, opacity: 0.5, shadowOffset: CGSize(width: 4, height: 4))
        
        guard manager.fileExists(atPath: documentDirectory.appendingPathComponent("imageForPlayScreen").path) else { return }
        getImageForPlayScreen()
    }
    
    func createChessboard() {
        chessboard = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.size.width - 16, height: view.bounds.size.width - 16)))
        chessboard.backgroundColor = .brown
        
        let sizeCell = (view.bounds.size.width - 16) / 8
        
        var i = 0 //счетчик для тагов клетки
        for row in 0..<8 {
            for column in 0..<8 {
                let cell = UIView(frame: CGRect(x: sizeCell * CGFloat(column),
                                                y: sizeCell * CGFloat(row),
                                                width: sizeCell,
                                                height: sizeCell))
                
                cell.backgroundColor = ((row + column) % 2) == 0 ? .white : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                cell.tag = i
                
                chessboard.addSubview(cell)
                i += 1
                
                let checkerImage = UIImageView(frame: CGRect(x: 5, y: 5, width: sizeCell - 10, height: sizeCell - 10))
                
                checkerImage.isUserInteractionEnabled = true //чтобы картинка реагировала на жесты
                
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognizer(_:)))
                longPressGesture.minimumPressDuration = 0.1
                longPressGesture.delegate = self
                checkerImage.addGestureRecognizer(longPressGesture)
                
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
                panGesture.delegate = self
                checkerImage.addGestureRecognizer(panGesture)
                
                guard !savedCheckers.isEmpty else {
                    guard row < 3 || row > 4, cell.backgroundColor == #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) else { continue }
                    checkerImage.image = UIImage(named: row < 3 ? styleOfChecker.whiteChecker! : styleOfChecker.blackChecker!)
                    checkerImage.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 4, height: 4))
                    checkerImage.tag = row < 3 ? 0 : 1
                    cell.addSubview(checkerImage)
                    
                    continue
                }
                
                if let checker = savedCheckers.first(where:{$0.positionTag == cell.tag}) {
                    checkerImage.image = UIImage(named: checker.colorTag == 0 ? styleOfChecker.whiteChecker! : styleOfChecker.blackChecker!)
                    checkerImage.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 4, height: 4))
                    checkerImage.tag = checker.colorTag == 0 ? 0 : 1
                    cell.addSubview(checkerImage)
                    
                }
            }
        }
        view.addSubview(chessboard)
        chessboard.center = view.center
        deleteSavedGame()
    }
    
    func getSaveData() {
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("checkers").path) {
            applyDataFromUserDefaults()
            
            timerMitutes.text = "0\(countMinute):"
            timerSeconds.text = "0\(countSecond)"
            
            currentChecker = savedCurrentChecker == 0 ? .white : .black
            
            getCheckers()
        } else {
            timerMitutes.text = "0\(countMinute):"
            timerSeconds.text = "0\(countSecond)"
        }
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
        self.savedCheckers = newArray ?? []
    }
    
    func getStyleChecker() {
        let fileURL = documentDirectory.appendingPathComponent("styleOfChecker")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return }
        
        guard let stylesOfChecker = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [StyleOfChecker] else { return }
        stylesOfChecker.forEach { style in
            if style.stateSwitch == true {
                self.styleOfChecker = style
            }
        }
    }
    
    func getImageForPlayScreen() {
        let fileURL = documentDirectory.appendingPathComponent("imageForPlayScreen")
            
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return }
            
        let image = UIImage(data: data)
        imageForPlayScreen.image = image
    }
    
    @objc func timerFunc() {
        countSecond += 1
        countMinute = countSecond / 60
        
        timerMitutes.text = countMinute < 10 ? "0\(countMinute):" : "\(countMinute):"
        timerSeconds.text = (countSecond % 60) < 10 ? "0\(countSecond % 60)" : "\(countSecond % 60)"
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        
        guard let checker = sender.view,
              let cell = sender.view?.superview,
              checker.tag == currentChecker.rawValue else { return }
        
        switch sender.state {
        case .began:
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = checker.transform.scaledBy(x: 1.3, y: 1.3)
            }
            
            chessboard.subviews.forEach { cellForMove in
                guard cellForMove.subviews.isEmpty, cellForMove.backgroundColor == #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) else { return }
                if currentChecker == .white {
                    if cellForMove.tag == cell.tag + 7 || cellForMove.tag == cell.tag + 9 {
                        
                        cellForMove.addBlurView()
                        
                        cellsForMove.append(cellForMove)
                    }
                }
                if currentChecker == .black {
                    if cellForMove.tag == cell.tag - 7 || cellForMove.tag == cell.tag - 9 {
                        
                        cellForMove.addBlurView()
                        
                        cellsForMove.append(cellForMove)
                    }
                }
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
            
            cellsForMove.forEach { fg in
                if fg.frame.contains(location) {
                    currentCell = fg
                }
            }

            sender.view?.frame.origin = CGPoint(x: 5, y: 5)
            guard let newCell = currentCell, let checker = sender.view else {  return }

            newCell.addSubview(checker)

            currentChecker = currentChecker == .white ? .black : .white
            cellsForMove.removeAll()
            chessboard.subviews.forEach { cell in
                cell.removeBlurView()
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

extension PlayViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        
//        timer?.invalidate()
//        timer = nil
        
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
}

