//
//  GalleryImageView.swift
//  Gallery
//
//  Created by Migu on 2019/1/18.
//  Copyright © 2019 VictorChee. All rights reserved.
//

import UIKit

class GalleryImageView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate var panTouchesCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2.5
        scrollView.isMultipleTouchEnabled = true
        scrollView.scrollsToTop = false
//        scrollView.contentSize = UIScreen.main.bounds.size
//        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        scrollView.alwaysBounceVertical = true
//        scrollView.contentInsetAdjustmentBehavior = .never
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped(_:)))
        addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        doubleTap.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        addGestureRecognizer(doubleTap)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        updateContentSize()
    }
    
    @objc func singleTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    private func updateContentSize() {
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        guard let imageSize = imageView.image?.size else { return }
        let screenSize = UIScreen.main.bounds.size
        let height = screenSize.width * imageSize.height / imageSize.width
        
        if imageSize.height / imageSize.width > screenSize.height / screenSize.width {
            // Long image
            imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
        } else {
            imageView.frame = CGRect(x: 0, y: screenSize.height / 2 - height / 2, width: screenSize.width, height: height)
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: height)
    }
    
    fileprivate func changeSize(offsetY: CGFloat) {
        let screenSize = UIScreen.main.bounds.size
        var multiple = (screenSize.height + offsetY * 1.75) / screenSize.height
        
        multiple = max(multiple, 0.4)
        scrollView.transform = CGAffineTransform(scaleX: multiple, y: multiple)
        scrollView.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2 - offsetY / 2)
    }
}

extension GalleryImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = scrollView.frame.width > scrollView.contentSize.width ? (scrollView.frame.width - scrollView.contentSize.width) * 0.5 : 0
        let offsetY = scrollView.frame.height > scrollView.contentSize.height ? (scrollView.frame.height - scrollView.contentSize.height) * 0.5 : 0
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        panTouchesCount = pan.numberOfTouches
        scrollView.clipsToBounds = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 && panTouchesCount == 1 {
            changeSize(offsetY: offsetY)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 && panTouchesCount == 1 && velocity.y < 0 && abs(velocity.y) > abs(velocity.x) {
            // Dismiss
        } else {
            changeSize(offsetY: 0)
            
            let offsetX = scrollView.frame.width > scrollView.contentSize.width ? (scrollView.frame.width - scrollView.contentSize.width) * 0.5 : 0
            let offsetY = scrollView.frame.height > scrollView.contentSize.height ? (scrollView.frame.height - scrollView.contentSize.height) * 0.5 : 0
            imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
        }
        
        panTouchesCount = 0
        scrollView.clipsToBounds = true
    }
}
