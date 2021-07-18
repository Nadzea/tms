//
//  ViewController.swift
//  homeworkLesson10
//
//  Created by Надежда Клименко on 13.07.21.
//

import UIKit

class ViewController: UIViewController {
    func addPanGesture(_ view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer))
        view.addGestureRecognizer(panGesture) //эта конструкция добавляет жест только для одной view?
    }
    var checkers: [UIView] = []
    var blackViews: [UIView] = []
    var whiteViews: [UIView] = []
    var moveChecker: UIView? = nil //переменная в которой будет храниться шашка, которя движется
    var defaultOrigin: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        for row in 1...8 {
            for column in 1...8 {
            let newView = UIView(frame: CGRect(x: column * 44 - 30,
                                               y: row * 44,
                                               width: 44,
                                               height: 44))
            newView.backgroundColor = (row + column) % 2 == 0 ? .white : .black
            view.addSubview(newView)
                //print(view.subviews)
                if newView.backgroundColor == .black {
                    blackViews.append(newView)
                } else {
                    whiteViews.append(newView)
                }
            }
        }
        
        for row in 1...3 {
            for column in 1...8 {
                let checker = UIView(frame: CGRect(x: column * 44 - 18 ,
                                                y: row * 44 + 12,
                                                width: 20,
                                                height: 20))
                    if (row + column) % 2 != 0 {
                        checker.backgroundColor = .gray
                        checkers.append(checker)
                    }
                view.addSubview(checker)
            }
        }
        
        for row in 6...8 {
            for column in 1...8 {
                let checker = UIView(frame: CGRect(x: column * 44 - 18 ,
                                                y: row * 44 + 12,
                                                width: 20,
                                                height: 20))
                    if (row + column) % 2 != 0 {
                        checker.backgroundColor = .white
                        checkers.append(checker)
                    }
                view.addSubview(checker)
            }
        }

        checkers.forEach { checker in
            addPanGesture(checker)
        }
        
        }
    @objc
    func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began:
                guard let senderView = sender.view else { //sender.view распознователь жестов к объекту?
                    return
                }
                    moveChecker = senderView
                    defaultOrigin = senderView.frame.origin //начальная позиция x y
        case .changed:
            guard moveChecker != nil else {return} //проверяем, что нажали имеено на шашку
            moveChecker?.frame.origin = CGPoint(x: defaultOrigin.x + translation.x, y: defaultOrigin.y + translation.y)
        case .ended:
            blackViews.forEach { blackcell in
                if blackcell.frame.contains((moveChecker?.frame.origin)!) {
                    moveChecker?.center.x = blackcell.center.x
                    moveChecker?.center.y = blackcell.center.y
                    var i: Int = 0
                    checkers.forEach { checker in
                        if moveChecker?.frame == checker.frame {
                            i += 1
                        }
                        if i == 2 {
                            moveChecker?.frame.origin = defaultOrigin
                        }
                    }
                }
                
                whiteViews.forEach { whitecell in
                    if whitecell.frame.contains((moveChecker?.frame.origin)!) {
                        moveChecker?.frame.origin = defaultOrigin
                    }
                }
            }
            sender.setTranslation(.zero, in: view) //сообщаем распознавателю жеста, что будем делать новый жест
            
        default: break
            
        }
        }
}

