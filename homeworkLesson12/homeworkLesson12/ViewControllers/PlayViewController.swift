//
//  playViewController.swift
//  homeworkLesson12
//
//  Created by Надежда Клименко on 21.07.21.
//

import UIKit

class PlayViewController: UIViewController {
    var chessboard: UIView!
    var timer: Timer?
    var countTick: Int = 0
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        createChessboard()
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        timerLabel.text = "\(countTick)"
        timerLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }
    func createChessboard() {
        //let sizeChessboard = view.bounds.size.width
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
                
                guard row < 3 || row > 4, cell.backgroundColor == .black else {continue}
                let whiteCheckerImage = UIImageView(image: UIImage(named: "whiteChecker"))
                whiteCheckerImage.frame = CGRect(x: 5,
                                                 y: 5,
                                                 width: sizeCell - 10,
                                                 height: sizeCell - 10)
                whiteCheckerImage.isUserInteractionEnabled = true //чтобы картинка реагировала на жесты
                whiteCheckerImage.layer.cornerRadius = whiteCheckerImage.frame.height / 2.0
                whiteCheckerImage.clipsToBounds = true //чтобы можно было закруглить картинку
                let blackCheckerImage = UIImageView(image: UIImage(named: "blackChecker"))
                blackCheckerImage.frame = CGRect(x: 5,
                                                 y: 5,
                                                 width: sizeCell - 10,
                                                 height: sizeCell - 10)
                blackCheckerImage.isUserInteractionEnabled = true
                blackCheckerImage.layer.cornerRadius = blackCheckerImage.frame.height / 2.0
                blackCheckerImage.clipsToBounds = true
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
                if row < 3 {
                    cell.addSubview(whiteCheckerImage)
                    whiteCheckerImage.addGestureRecognizer(panGesture)
                } else {
                    cell.addSubview(blackCheckerImage)
                    blackCheckerImage.addGestureRecognizer(panGesture)
                }
            }
        }
        view.addSubview(chessboard)
        chessboard.center = view.center
    }
    @IBAction func playBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @objc func timerFunc() {
        countTick += 1
        timerLabel.text = "\(countTick)"
    }
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
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
        default: break
        }
    }
}
