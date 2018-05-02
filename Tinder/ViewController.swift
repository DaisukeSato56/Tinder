//
//  ViewController.swift
//  Ti
//
//  Created by 佐藤大介 on 2018/05/02.
//  Copyright © 2018年 sato daisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var centerOfCard:CGPoint!
    var people = [UIView]()
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        basicCardのセンターの位置情報を代入
        centerOfCard = basicCard.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
//        letは変更しない変数 = 定数
//        basicCardに関する情報がsenderに入っている。
        let card = sender.view!
        
//        ドラッグ&ドロップの距離を入れる代数
//        in以下を基準にどれくらい動いたか
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
//        角度を変える処理
        let xFromCenter = card.center.x - view.center.x
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        if xFromCenter > 0 {
            likeImageView.image = UIImage(named: "good.png")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        } else if xFromCenter < 0 {
            likeImageView.image = UIImage(named: "bad.png")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
//        スワイプして話した時の処理
//        senderの状態がUIGestureRecognizerState.endedであれば
        if sender.state == UIGestureRecognizerState.ended {
//            左に大きくスワイプされた時の処理
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x - 300, y: card.center.y)
                })
                return
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x + 300, y: card.center.y)
                })
                return
            }
            
//            元に戻るための処理
//            クロージャー(無名関数)の使用
//            クラスのビューコントローラーの直下にある変数の場合selfが必要。
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.centerOfCard
                card.transform = .identity
            })
            likeImageView.alpha = 0
        }
    }
}

