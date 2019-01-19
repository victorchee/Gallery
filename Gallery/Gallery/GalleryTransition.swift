//
//  GalleryTransition.swift
//  Gallery
//
//  Created by Migu on 2019/1/18.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class GalleryTransition: NSObject {
    var isDismissal = false
}

extension GalleryTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        if !isDismissal {
            container.addSubview(toViewController.view)
            
            
        }
    }
}
