//
//  PlayViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit
import AVFoundation

enum Checkers: Int {
    case white = 0
    case black = 1
}

class PlayViewController: UIViewController {
    
    @IBOutlet weak var timerSeconds: UILabel!
    @IBOutlet weak var timerMitutes: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var gameTime: UILabel!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var imageForPlayScreen: UIImageView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var congratulationsLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    let dateFormater = DateFormatter()
    let date = Date()
    var chessboard: UIView!
    var timer: Timer?
    var countSecond: Int = 0
    var countMinute: Int = 0
    var currentChecker: Checkers = .white
    var savedCheckers: [Checker] = []
    var styleOfChecker = StyleOfChecker(whiteChecker: "style1WhiteChecker",
                                         blackChecker: "style1BlackChecker",
                                         stateSwitch: true)
    var cellsForMove: [UIView] = []
    var names: [String] = []
    var saveData: SaveData? = nil
    var movingPlayer: String = ""
    var playerWithWhiteChecker: String = ""
    var playerWithBlackChecker: String = ""
    var canFight: Bool = false
    //var checkerBeaten: Checker? = nil
    var mass: [(checker: Int, cell: Int, checkerBeaten: Int)] = [] //шашка которая может бить и на какую позицию она после этого становиться и какую шашку бьет
    var playerMusic: AVPlayer?
    
    
    override func viewDidLoad() {  //1
        super.viewDidLoad()
        
        backButton.delegate = self
        
        getSaveData()
        
        createChessboard()
        findFight()
        
        screenSettings()
        
        playMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {  //2
        super.viewWillAppear(true)
        
        helloLabel.center.x -= view.bounds.width
        container.center.y -= view.bounds.height
        timerView.center.y -= view.bounds.height
        dateLabel.center.y -= view.bounds.height
        congratulationsLabel.center.y -= view.bounds.height
        winnerLabel.center.y -= view.bounds.height
        
    }
    
    override func viewDidAppear(_ animated: Bool) { //3
        super.viewDidAppear(true)
        
        getNames()

        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut) {
            self.helloLabel.center.x += self.view.bounds.width
        } completion: { finished in
            self.helloLabel.text = self.currentChecker == .white ? "\(self.playerWithWhiteChecker), your move." : "\(self.playerWithBlackChecker), your move."
        }
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
            self.container.center.y += self.view.bounds.height
        }
        
        setDate()
        timerSettings()

        UIView.animate(withDuration: 2, delay: 0.3, options: .curveEaseOut) {
            self.timerView.center.y += self.view.bounds.height
            self.dateLabel.center.y += self.view.bounds.height
        } completion: { finished in
            self.timer = Timer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer!, forMode: .common)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    func setDate() {
        gameDate.addAttributedText(with: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), foregroundColor: #colorLiteral(red: 0.7087161869, green: 0.993346738, blue: 1, alpha: 1), strokeWidth: -3, size: 39)
        
        dateLabel.addAttributedText(with: .black, foregroundColor: .gray, strokeWidth: -3, size: 36)
        dateLabel.addBorder(with: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), borderWidth: 3, cornerRadius: 10)
    }
    
    func timerSettings() {
        gameTime.text = "Game time"
        gameTime.addAttributedText(with: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), foregroundColor: #colorLiteral(red: 0.7087161869, green: 0.993346738, blue: 1, alpha: 1), strokeWidth: -3, size: 39)
        timerView.addBorder(with: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), borderWidth: 3, cornerRadius: 10)
        
        timerSeconds.addAttributedText(with: .black, foregroundColor: .gray, strokeWidth: -3, size: 36)
        timerMitutes.addAttributedText(with: .black, foregroundColor: .gray, strokeWidth: -3, size: 36)
    }
    
    func screenSettings() {
        self.view.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4803237184, green: 0.7373365856, blue: 0.8808781744, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))

        chessboard.addShadow(with: .black, opacity: 0.5, shadowOffset: CGSize(width: 4, height: 4))
        congratulationsLabel.textColor = #colorLiteral(red: 0.9919819609, green: 1, blue: 0.6366164679, alpha: 1)
        winnerLabel.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    func createChessboard() {
        chessboard = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.size.width - 16, height: view.bounds.size.width - 16)))
        chessboard.backgroundColor = .brown
        
        let sizeCell = (view.bounds.size.width - 16) / 8
        
        var i = 0 //счетчик для тагов клетки
        var j = 0 //счетчик для тагов шашки
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
                    
                    checkerImage.image = UIImage(named: ((row < 3 ? styleOfChecker.whiteChecker! : styleOfChecker.blackChecker!)))
                    checkerImage.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 4, height: 4))
                    cell.addSubview(checkerImage)
                    checkerImage.tag = j
                    j += 1
                    continue
                }
                
                if let checker = savedCheckers.first(where:{$0.positionTag == cell.tag}) {
                    checkerImage.image = UIImage(named: checker.colorTag! < 12 ? styleOfChecker.whiteChecker! : styleOfChecker.blackChecker!)
                    checkerImage.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 4, height: 4))
                    checkerImage.tag = checker.colorTag!// == 0 ? 0 : 1
                    cell.addSubview(checkerImage)
                    
                }
            }
        }
        view.addSubview(chessboard)
        
        chessboard.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        SaveData.deleteSavedGame()
    }
    
    func getNames() {
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("savedNames").path) {
            names = SaveData.getNamesOfPlayers()
    
            helloLabel.text = "Hello \(names[0]) and \(names[1])!!!!!"
            
            playerWithWhiteChecker = names.randomElement()!
            names.forEach { player in
                if player != playerWithWhiteChecker {
                    playerWithBlackChecker = player
                }
            }
        } else {
            guard let name1 = saveData!.nameOfPlayer1, let name2 = saveData!.nameOfPlayer2 else { return }
            helloLabel.text = "I am glad to see you again!"
            playerWithWhiteChecker = name1
            playerWithBlackChecker = name2
            
        }
        helloLabel.addAttributedText(with: .white, foregroundColor: .black, strokeWidth: -3, size: 40)
    }
    
    func getSaveData() {
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("savedGame").path) {
            saveData = SaveData.getSaveGame()
            savedCheckers = saveData?.savedCheckersPosition as! [Checker]
            
            countSecond = (saveData?.savedCountSeconds)!
            countMinute = (saveData?.savedCountMinutes)!
            timerSeconds.text = (countSecond % 60) < 10 ? "0\(countSecond % 60)" : "\(countSecond % 60)"
            timerMitutes.text = countMinute < 10 ? "0\(countMinute):" : "\(countMinute):"
            
            gameDate.text = "The game started"
            dateLabel.text = saveData?.savedDateOfStartGame
            
            currentChecker = saveData?.savedCurrentChecker == 0 ? .white : .black
            
        } else {
            timerMitutes.text = "0\(countMinute):"
            timerSeconds.text = "0\(countSecond)"
            
            gameDate.text = "Today's date"
            
            dateFormater.dateFormat = "dd.MM.yy"
            dateLabel.text = dateFormater.string(from: date)
            
        }
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("styleOfChecker").path) {
            let stylesOfChecker = SaveData.getStyleChecker()
            
            stylesOfChecker.forEach { style in
                if style.stateSwitch == true {
                    styleOfChecker = style
                }
            }
        }
        guard manager.fileExists(atPath: documentDirectory.appendingPathComponent("imageForPlayScreen").path) else { return }
        imageForPlayScreen.image = SaveData.getImageForScreen()
    }
    
    func saveChekers() -> [Checker] {
        savedCheckers = []
        chessboard.subviews.forEach { cell in
            cell.removeBlurView()
        }
        chessboard.subviews.forEach { cell in
            if !cell.subviews.isEmpty {
                cell.subviews.forEach { checker in
                    let savedChecker = Checker(colorTag: checker.tag, positionTag: cell.tag)
                    savedCheckers.append(savedChecker)
                }
            }
        }
        
        return savedCheckers
    }
    
    func findMoving(for checker:UIView) {
        
        let cell = checker.superview
        chessboard.subviews.forEach { cellForMove in
            guard cellForMove.subviews.isEmpty, cellForMove.backgroundColor == #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), let startCell = cell else { return }
            
            let diff1 = currentChecker == .white ? 7 : -7
            let diff2 = currentChecker == .white ? 9 : -9
            
            if cellForMove.tag == startCell.tag + diff1 || cellForMove.tag == startCell.tag + diff2 {
                cellForMove.addBlurView()
                cellsForMove.append(cellForMove)
            }
        }
    }
    
    func findFight()   {

        let arrayOfChecker = saveChekers()

        var startChecker: Checker? = nil
        var checkerForFight: Checker? = nil //шашка которую бьем

        if currentChecker == .white {

            arrayOfChecker.forEach { checker in

                if checker.colorTag! < 12 {
                    startChecker = checker
                }
                arrayOfChecker.forEach { fightChecker in

                    guard let startChecker = startChecker else { return }

                    if fightChecker.colorTag! >= 12 && (fightChecker.positionTag == startChecker.positionTag! + 9 || fightChecker.positionTag == startChecker.positionTag! + 7 || fightChecker.positionTag == startChecker.positionTag! - 9 || fightChecker.positionTag == startChecker.positionTag! - 7 ) {

                        checkerForFight = fightChecker

                        chessboard.subviews.forEach { cell in

                            guard let checkerForFight = checkerForFight else { return }

                            if cell.subviews.isEmpty, cell.backgroundColor == #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cell.tag == startChecker.positionTag! - 2 * (startChecker.positionTag! - fightChecker.positionTag!) {

                                cell.addBlurView()
                                cellsForMove.append(cell)
                                canFight = true
                                mass.append((checker: startChecker.colorTag!, cell: cell.tag, checkerBeaten: checkerForFight.colorTag!))
                                
                            }
                        }
                    }
                }
            }
            //print(mass)

        } else {

            arrayOfChecker.forEach { checker in

                if checker.colorTag! >= 12 {
                    startChecker = checker
                }

                arrayOfChecker.forEach { fightChecker in

                    guard let startChecker = startChecker else { return }

                    if fightChecker.colorTag! < 12  && (fightChecker.positionTag == startChecker.positionTag! + 9 || fightChecker.positionTag == startChecker.positionTag! + 7 || fightChecker.positionTag == startChecker.positionTag! - 9 || fightChecker.positionTag == startChecker.positionTag! - 7 ) {

                        checkerForFight = fightChecker

                        chessboard.subviews.forEach { cell in

                            guard let checkerForFight = checkerForFight else { return }

                            if cell.subviews.isEmpty, cell.backgroundColor == #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cell.tag == startChecker.positionTag! - 2 * (startChecker.positionTag! - checkerForFight.positionTag!) {

                                cell.addBlurView()
                                cellsForMove.append(cell)
                                canFight = true
                                mass.append((checker: startChecker.colorTag!, cell: cell.tag, checkerBeaten: checkerForFight.colorTag!))
                                
                            }
                        }
                    }
                }
            }
            //print(mass)
        }
    }
    
    func smartBlur(for checker: UIView) {
        
        chessboard.subviews.forEach { cell in
            cell.removeBlurView()
        }
        mass.forEach { tuple in
            if checker.tag == tuple.checker {
                chessboard.subviews.forEach { cell in
                    if cell.tag == tuple.cell {
                        cell.addBlurView()
                    }
                }
            }
        }
    }
    
    func returnSmartBlur() {
        mass.forEach { tuple in
            chessboard.subviews.forEach { cell in
                if cell.tag == tuple.cell, cell.subviews.isEmpty {
                    cell.addBlurView()
                }
            }
        }
    }
    
    func congratulations() {
        
        let winner = winner()

        if winner != "" {
            self.view.bringSubviewToFront(congratulationsLabel)
            self.view.bringSubviewToFront(winnerLabel)
        
            timer?.invalidate()
            timer = nil
            
            helloLabel.text = ""
        
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
                self.congratulationsLabel.center.y += self.view.bounds.height
            }
            winnerLabel.text = "\(winner), you have won!"

            UIView.animate(withDuration: 2, delay: 0.3, options: .curveEaseOut) {
                self.winnerLabel.center.y += self.view.bounds.height
            }
        }
    }
    
    func winner() -> String {
        let checkChecker = saveChekers()
        var blackCheckers: Int = 0
        var whiteCheckers: Int = 0
        var winner: String = ""
        checkChecker.forEach { checker in
            if checker.colorTag! < 12 {
                whiteCheckers += 1
            } else {
                blackCheckers += 1
            }
        }
        if whiteCheckers == 0 {
            winner = playerWithBlackChecker
        }
        if blackCheckers == 0 {
            winner = playerWithWhiteChecker
        }
        return winner
    }
    
    func checkerInLadies() {
        let massCheckers = saveChekers()
        var number: Int? = nil
        
        massCheckers.forEach { checker in
            if (checker.colorTag! < 12 && (checker.positionTag == 62 || checker.positionTag == 60 || checker.positionTag == 58 || checker.positionTag == 56)) || (checker.colorTag! >= 12 && (checker.positionTag == 1 || checker.positionTag == 3 || checker.positionTag == 5 || checker.positionTag == 7)) {
                number = checker.positionTag
            }
        }
                
        if let cell = chessboard.subviews.first(where:{$0.tag == number}) {
            cell.subviews.forEach { checker in
                let tiaraImage = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(checker.frame.width), height: Int(checker.frame.height)))
                tiaraImage.image = UIImage(named: "tiara")
                checker.addSubview(tiaraImage)
            }
        }
    }
    
    func playMusic() {
        guard let pathMusic = Bundle.main.path(forResource: "musicForApp", ofType: "mp3") else { return }
        
        let urlAudio = URL(fileURLWithPath: pathMusic)
        let asset = AVAsset(url: urlAudio)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        playerMusic = player
        
        let playMusic = SaveData.getPlayMusicIsNeeded()
        if playMusic == true {
            playerMusic?.play()
        } else {
            playerMusic?.pause()
        }
    }
    
    @objc func timerFunc() {
        countSecond += 1
        countMinute = countSecond / 60
        
        timerMitutes.text = countMinute < 10 ? "0\(countMinute):" : "\(countMinute):"
        timerSeconds.text = (countSecond % 60) < 10 ? "0\(countSecond % 60)" : "\(countSecond % 60)"
    }
    
    @objc func longPressRecognizer(_ sender: UILongPressGestureRecognizer) {
        
        guard let checker = sender.view, (currentChecker == .white && checker.tag < 12) || (currentChecker == .black && checker.tag >= 12) else { return }
        
        switch sender.state {
        case .began:
            
            smartBlur(for: checker)
                
            if canFight == false {
                cellsForMove.removeAll()
                findMoving(for: checker)
            }
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = checker.transform.scaledBy(x: 1.3, y: 1.3)
            }
            
        case .ended:
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = .identity
            }
            if canFight == false {
                chessboard.subviews.forEach { cell in
                    cell.removeBlurView()
                }
            }
            
            returnSmartBlur() // чтобы опять появился блюр, если нужно бить, но просто подергали шашку
                
            
        default: break
        }
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        
        guard let checker = sender.view, (currentChecker == .white && checker.tag < 12) || (currentChecker == .black && checker.tag >= 12) else { return }
                
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

            var currentCell: UIView? = nil //клетка на которой заканчивается движение
            var currentBeatenChecker: Int? = nil //шашка которую будем бить
            
            cellsForMove.forEach { cell in
                if canFight == true {
                    mass.forEach { tuple in
                        if checker.tag == tuple.checker, cell.tag == tuple.cell, cell.frame.contains(location) {
                            currentCell = cell
                            currentBeatenChecker = tuple.checkerBeaten
                        }
                    }
                } else {
                    if cell.frame.contains(location) {
                        currentCell = cell
                    }
                }
            }
    
            sender.view?.frame.origin = CGPoint(x: 5, y: 5)
            guard let newCell = currentCell, let checker = sender.view else {  return }

            newCell.addSubview(checker)
            
            chessboard.subviews.forEach { cell in
                cell.subviews.first(where: {$0.tag == currentBeatenChecker})?.removeFromSuperview()
            }
            checkerInLadies()
            congratulations()
            
            if canFight == true {
                
                canFight = false
                cellsForMove.removeAll()
                mass.removeAll()
                findFight()
    
                if canFight == true {
                    
                    mass.removeAll(where: {$0.checker != checker.tag })
                    //print("2: \(mass)")
                    smartBlur(for: checker)
                    if mass.isEmpty {
                        canFight = false
                    }
                }
            }
            
            if canFight == false {
                currentChecker = currentChecker == .white ? .black : .white
                helloLabel.text = currentChecker == .white ? "\(playerWithWhiteChecker), your move." : "\(playerWithBlackChecker), your move."
                findFight()
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
        
        presentAlertController(with: nil,
                               message: "Do you want to leave the game?",
                               actions: UIAlertAction(title: "Save and leave the game",
                               style: .default,
                               handler: { _ in
                                self.view.removeBlurView()
                                self.playerMusic?.pause()
                                
                                self.saveData = SaveData(savedCheckersPosition: self.saveChekers(), savedCountSeconds: self.countSecond, savedCountMinutes: self.countMinute, savedCurrentChecker: self.currentChecker.rawValue, nameOfPlayer1: self.playerWithWhiteChecker, nameOfPlayer2: self.playerWithBlackChecker, date: self.dateLabel.text)

                                SaveData.saveGame(saveData: self.saveData!)
                                SaveData.deleteSavedNames()
                                
                                self.dismiss(animated: true, completion: nil)}),
                                        UIAlertAction(title: "Leave the game",
                                                      style: .default,
                                                      handler: { _ in
                                                        self.playerMusic?.pause()
                                                        self.dismiss(animated: true, completion: nil)}))
    }
}

