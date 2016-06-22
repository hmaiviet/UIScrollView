//
//  ViewScroll.swift
//  UIScrollView
//
//  Created by VietHung on 6/11/16.
//  Copyright © 2016 VietHung. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate{
    
    
    @IBAction func slider(sender: UISlider) {
        scrollView.setZoomScale(CGFloat(sender.value), animated: true)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let imgView = UIImageView(image: UIImage(named: "shop1-0.jpg"))
        imgView.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg:"))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("doubleTapImg:"))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        imgView.addGestureRecognizer(doubleTap)
        imgView.contentMode = .ScaleAspectFit
        photo = imgView
        scrollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        self.scrollView.addSubview(imgView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return photo
    }
    
    func tapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        scrollView.zoomToRect(zoomRect, animated: true)
    }
}

    