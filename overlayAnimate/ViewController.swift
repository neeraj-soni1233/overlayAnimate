//
//  ViewController.swift
//  overlayAnimate
//
//  Created by Neeraj Soni on 05/09/19.
//  Copyright © 2019 Neeraj Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var mainOverlayView = UIView()
    let tempView = UIView()
    var imageScrollView: UIScrollView = UIScrollView()
    var scrollImage:[ScrollImage] = [];
    static var overlayButtonIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome Overlay"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageScrollView.delegate = self
        imageScrollView.showsHorizontalScrollIndicator = false
        self.initOverlay()
    }


}
extension ViewController
{
    
    func initOverlay()  {
        mainOverlayView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            mainOverlayView.frame = (appDelegate.window?.frame)!
            mainOverlayView.backgroundColor = UIColor.black
            mainOverlayView.alpha = 0.5
            appDelegate.window?.addSubview(mainOverlayView)
            tempView.backgroundColor = UIColor.white
            tempView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height:self.view.frame.height)
            let viewI = self.overlayView(frame:tempView.bounds)
            //viewI.backgroundColor = UIColor.green
            tempView.addSubview(viewI)
            appDelegate.window?.addSubview(tempView)
            tempView.layer.cornerRadius =  12
           // tempView.cornerRadius = 12
            UIView.animate(withDuration: 0.7) {
                self.tempView.frame = CGRect(x: 0, y: self.view.frame.height/2 - 40, width: self.view.frame.width, height: self.view.frame.height)
            }
            
        }
    }
    
    func overlayView(frame:CGRect) -> UIView{
        let tempView = UIView()
        let baseFrame  = frame
        tempView.frame = baseFrame
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y:0, width: baseFrame.width, height: baseFrame.height/3)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img1")
        imageView.tag = 500
        
        
        // scroll view
        let slide = self.createSlides(frame: imageView.bounds)
        scrollImage = slide
        let scrolview = self.bottomView(frame:imageView.bounds,slides: slide)
        tempView.addSubview(scrolview)
        let textLabel = UILabel()
        textLabel.frame = CGRect(x: 20, y: imageView.frame.origin.y + imageView.frame.height + 5.0 , width: baseFrame.width - 20, height: 30)
        textLabel.text = "Welcome in Night View"
        textLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        textLabel.textColor = UIColor.black
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.tag = 700
        tempView.addSubview(textLabel)
        
        // button
        let button1 = UIButton()
        button1.frame = CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.origin.y + textLabel.frame.height + 5 , width: 30, height: 4)
        button1.backgroundColor = UIColor.green
        button1.tag = 100
        button1.layer.cornerRadius = 2
        
        tempView.addSubview(button1)
        let button2 = UIButton()
        button2.frame = CGRect(x: button1.frame.origin.x + 30 + 5, y: textLabel.frame.origin.y + textLabel.frame.height + 5 , width: 30, height: 4)
        button2.backgroundColor = UIColor.gray
        //   button2.addTarget(self, action: #selector(self.imageButtonClicked(sender:)), for: .touchUpInside)
        button2.tag = 200
        button2.layer.cornerRadius = 2
        tempView.addSubview(button2)
        
        let button3 = UIButton()
        button3.frame = CGRect(x: button2.frame.origin.x + 30 + 5, y: textLabel.frame.origin.y + textLabel.frame.height + 5 , width: 30, height: 4)
        // button3.backgroundColor = UIColor.lightGray
        button3.backgroundColor  = UIColor.gray
        //   button3.addTarget(self, action: #selector(self.imageButtonClicked(sender:)), for: .touchUpInside)
        button3.tag = 300
        button3.layer.cornerRadius = 2
        tempView.addSubview(button3)
        
        let tapToBigin = UIButton()
        tapToBigin.frame = CGRect(x: 10, y: button3.frame.origin.y + button3.frame.height + 18 , width: 160, height: 38)
        tapToBigin.backgroundColor = UIColor.lightGray
        tapToBigin.addTarget(self, action: #selector(self.imageButtonClicked(sender:)), for: .touchUpInside)
        tapToBigin.setTitle("Show Image", for: .normal)
        tapToBigin.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        tapToBigin.setTitleColor(UIColor.white, for: .normal)
        tapToBigin.backgroundColor = UIColor.green
        
        
        tapToBigin.tag = 400
        tapToBigin.layer.cornerRadius = 19
        tempView.addSubview(tapToBigin)
        
        // skip button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: baseFrame.width - 60, y: button3.frame.origin.y + button3.frame.height + 18  , width: 45, height: 38)
        nextButton.addTarget(self, action: #selector(self.imageButtonClicked(sender:)), for: .touchUpInside)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.gray, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "HelveticaNeue-medium", size: 18)
        
        nextButton.tag = 600
        tempView.addSubview(nextButton)
        
        return tempView
        
    }
    @objc func imageButtonClicked(sender:UIButton)  {
        switch sender.tag {
        case 100:
            if let imageView = tempView.viewWithTag(500) as? UIImageView {
                imageView.image = UIImage(named: "img1")
            }
            if let butt = tempView.viewWithTag(100) as? UIButton {
                butt.backgroundColor = UIColor.green
            }
            if let butt = tempView.viewWithTag(200) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            if let butt = tempView.viewWithTag(300) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            break
        case 200:
            if let imageView = tempView.viewWithTag(500) as? UIImageView {
                imageView.image = UIImage(named: "img2")
            }
            
            if let butt = tempView.viewWithTag(200) as? UIButton {
                butt.backgroundColor = UIColor.green
            }
            if let butt = tempView.viewWithTag(100) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            if let butt = tempView.viewWithTag(300) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            break
        case 300:
            if let imageView = tempView.viewWithTag(500) as? UIImageView {
                imageView.image = UIImage(named: "img1")
            }
            if let butt = tempView.viewWithTag(300) as? UIButton {
                butt.backgroundColor = UIColor.green
            }
            if let butt = tempView.viewWithTag(100) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            if let butt = tempView.viewWithTag(200) as? UIButton {
                butt.backgroundColor = UIColor.gray
            }
            break
        case 400:
            if let butt = tempView.viewWithTag(400) as? UIButton {
               
                butt.backgroundColor = UIColor.green
                for view in tempView.subviews{
                    view.removeFromSuperview()
                }
                for view in imageScrollView.subviews{
                    view.removeFromSuperview()
                }
                tempView.removeFromSuperview()
                mainOverlayView.removeFromSuperview()
                
                print("add what you want to do ")
                
            }
            break
        case 600:  // next button
            if let butt = tempView.viewWithTag(600) as? UIButton {
              
                UIView.animate(withDuration: 0.3,delay:0.0, animations: {
                    self.tempView.frame = CGRect(x: 0, y: self.view.frame.height + 100 , width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { finished in
                    for view in self.tempView.subviews{
                        view.removeFromSuperview()
                    }
                    for view in self.imageScrollView.subviews{
                        view.removeFromSuperview()
                    }
                    self.tempView.removeFromSuperview()
                    self.mainOverlayView.removeFromSuperview()
                })
                
                return
               /* this is if we dont want to animate to bottom
                for view in tempView.subviews{
                    view.removeFromSuperview()
                }
                for view in imageScrollView.subviews{
                    view.removeFromSuperview()
                }
                tempView.removeFromSuperview()
                mainOverlayView.removeFromSuperview()*/
            }
            break
        default:
            break
        }
        
        
    }
    func createSlides(frame:CGRect) -> [ScrollImage] {
        
        let slide1 = ScrollImage()
        slide1.frame = frame
        
        slide1.image = UIImage(named: "img1")
        
        let slide2 = ScrollImage()
        slide2.frame = frame
        
        slide2.image = UIImage(named: "img2")
        
        let slide3 = ScrollImage()
        slide3.frame = frame
        
        slide3.image = UIImage(named: "img1")
        
        return [slide1, slide2, slide3]
    }
    
    
    func bottomView(frame: CGRect, slides : [ScrollImage])->UIScrollView {
        imageScrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageScrollView.contentSize = CGSize(width: frame.width * CGFloat(slides.count), height: frame.height)
        imageScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            imageScrollView.addSubview(slides[i])
        }
        return imageScrollView
    }
    
    // scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            // scrollView.contentOffset.y = 0
            return
        }
        let maxHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let presentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let HorizontalOffsetpercentge: CGFloat = presentHorizontalOffset / maxHorizontalOffset
        let VerticalOffsetperctge: CGFloat = currentVerticalOffset / maximumVerticalOffset
        let percentOffset: CGPoint = CGPoint(x: HorizontalOffsetpercentge, y: VerticalOffsetperctge)
        print(percentOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
             scrollImage[0].transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
             scrollImage[1].transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            ViewController.overlayButtonIndex = 0
            self.buttonChnageOnFly(index: ViewController.overlayButtonIndex)
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
              scrollImage[0].transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
             scrollImage[1].transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            ViewController.overlayButtonIndex = 1
            self.buttonChnageOnFly(index: ViewController.overlayButtonIndex)
        }
        else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
             scrollImage[1].transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            scrollImage[2].transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            ViewController.overlayButtonIndex = 2
            self.buttonChnageOnFly(index: ViewController.overlayButtonIndex)
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
              scrollImage[1].transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            scrollImage[2].transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
    
    func buttonChnageOnFly(index:Int)  {
        switch index {
        case 0:
            if let txtLbl = tempView.viewWithTag(700) as? UILabel {
                txtLbl.text = "Welcome in Night View"
            }
            
            if let butn = tempView.viewWithTag(100) as? UIButton {
                butn.backgroundColor = UIColor.green
            }
            if let butn = tempView.viewWithTag(200) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            if let butn = tempView.viewWithTag(300) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            
            break
        case 1:
            
            if let txtLbl = tempView.viewWithTag(700) as? UILabel {
                txtLbl.text = "Healthy Food Yummy!!!"
            }
            
            if let butn = tempView.viewWithTag(100) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            if let butn = tempView.viewWithTag(200) as? UIButton {
                butn.backgroundColor = UIColor.green
            }
            if let butn = tempView.viewWithTag(300) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            break
        case 2:
            if let txtLbl = tempView.viewWithTag(700) as? UILabel {
                txtLbl.text = "Green is  good for eyes :))))"
            }
            
            if let butn = tempView.viewWithTag(100) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            if let butn = tempView.viewWithTag(200) as? UIButton {
                butn.backgroundColor = UIColor.gray
            }
            if let butn = tempView.viewWithTag(300) as? UIButton {
                    butn.backgroundColor = UIColor.green
            }
            
            break
        default:
            break
        }
    }
   
}

class ScrollImage: UIImageView {
    
}


