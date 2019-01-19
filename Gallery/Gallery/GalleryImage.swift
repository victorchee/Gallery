//
//  GalleryImage.swift
//  Gallery
//
//  Created by Migu on 2019/1/18.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class GalleryImage: NSObject {
    var smallImageSize = CGSize(width: 1, height: 1)
    var smallImageView: UIImageView?
    
    var bigImageSize = CGSize(width: 1, height: 1)
    var bigImageView: UIImageView?
    var bigScrollView: UIScrollView?
    
    var currentImage: UIImage? {
        get {
            return smallImageView?.image
        }
    }
    /// 在原始的window上的frame
    var smallImageViewFrameOriginWindow: CGRect {
        guard let imageView = smallImageView else { return CGRect.zero }
        return imageView.convert(imageView.bounds, to: imageView.window!)
    }
    /// 图片放大后充满屏幕后的frame
    var imageViewFrameShowWindow: CGRect {
        let screenSize = UIScreen.main.bounds.size
        let height = screenSize.width * smallImageSize.height / smallImageSize.width
        if smallImageSize.height / smallImageSize.width > screenSize.height / screenSize.width {
            // Long image
            return CGRect(x: 0, y: 0, width: screenSize.width, height: height)
        } else {
            return CGRect(x: 0, y: screenSize.height / 2 - height / 2, width: screenSize.width, height: height)
        }
    }
    /// 当前如果消失创建的image应该的frame
    var bigImageViewFrameOnScrollView: CGRect {
        guard let frame = bigScrollView?.frame, let center = bigScrollView?.center else { return CGRect.zero }
        let height = frame.width * bigImageSize.height / bigImageSize.width
        return CGRect(x: center.x - frame.width / 2, y: center.y - height / 2, width: frame.width, height: height)
    }
}
