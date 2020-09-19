//
//  DVDBounceViewController.swift
//  DVDBounce
//
//  Created by 楊敦富 on 2020/9/19.
//

import UIKit

final class DVDBounceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewConstraints()
        initViewProperty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopTimer()
    }
    
    private func initViewConstraints(){
        self += dvdImageView
        dvdImageView.frame = CGRect(x: 1, y: 1, width: 180, height: 90)
    }
    
    private func initViewProperty(){
        self.view.backgroundColor = .white
    }
    
    private func startTimer(){
        stopTimer()
        Timer.scheduledTimer(withTimeInterval: 1 / 59.97, repeats: true, block: {
            _ in
            
            var isHorizHit = false
            var isVertHit = false
            
            if  self.isDown{
                if  self.view.bounds.maxY < self.dvdImageView.frame.maxY{
                    self.isDown = false
                    isVertHit = true
                }
            }else{
                if  self.view.bounds.minY > self.dvdImageView.frame.minY{
                    self.isDown = true
                    isVertHit = true
                }
            }
            
            if  self.isRight{
                if  self.view.bounds.maxX < self.dvdImageView.frame.maxX{
                    self.isRight = false
                    isHorizHit = true
                }
            }else{
                if  self.view.bounds.minX > self.dvdImageView.frame.minX{
                    self.isRight = true
                    isHorizHit = true
                }
            }
            
            if  isVertHit || isHorizHit{
                self.dvdImageView.tintColor = .random
            }
            
            let factor:CGFloat = 375 / 3 / 59.97
            let xVel: CGFloat = self.isRight ? 1 * factor : -1 * factor
            let yVel: CGFloat = self.isDown ? 2 * factor : -2 * factor
            let rect = self.dvdImageView.frame.offsetBy(dx: xVel, dy: yVel)
            self.dvdImageView.frame = rect
        })
    }
    
    private func stopTimer(){
        if  let t = timer{
            t.invalidate()
            timer = nil
        }
    }
    
    private(set) lazy var dvdImageView: UIImageView = {
        let i = UIImage(named: "dvd")
        let im = UIImageView(image: i)
        im.contentMode = .scaleAspectFit
//        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    }()
    
    var timer: Timer?
    var isRight = true
    var isDown = true
}

extension DVDBounceViewController{
    static func +=(l: DVDBounceViewController, r: UIView){
        l.view.addSubview(r)
    }
    
    private var xLeft:NSLayoutXAxisAnchor{
        view.leftAnchor
    }
    
    private var xRight:NSLayoutXAxisAnchor{
        view.rightAnchor
    }
    
    private var xTop:NSLayoutYAxisAnchor{
        view.safeAreaLayoutGuide.topAnchor
    }
    
    private var xBottom:NSLayoutYAxisAnchor{
        view.bottomAnchor
    }
    
    private var xCenter:NSLayoutXAxisAnchor{
        view.centerXAnchor
    }
    
    private var yCenter:NSLayoutYAxisAnchor{
        view.centerYAnchor
    }
    
    private var xWidth: NSLayoutDimension{
        view.widthAnchor
    }
    
    private var xHeight: NSLayoutDimension{
        view.heightAnchor
    }
}


//Swift >= 4.2
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
