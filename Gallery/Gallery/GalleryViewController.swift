//
//  GalleryViewController.swift
//  Gallery
//
//  Created by Migu on 2019/1/18.
//  Copyright © 2019 VictorChee. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var images: [UIImage?]!
    var selectedIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = .overCurrentContext
//        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenSize = UIScreen.main.bounds.size
        
        for image in images {
            let imageView = Bundle.main.loadNibNamed("GalleryImageView", owner: nil, options: nil)?.first as! GalleryImageView
            let index = images.index(of: image)!
            imageView.frame = CGRect(x: screenSize.width * CGFloat(index), y: 0, width: screenSize.width, height: screenSize.height)
            imageView.imageView.image = image
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width * CGFloat(images.count), height: screenSize.height)
        scrollView.contentOffset = CGPoint(x: screenSize.width * CGFloat(selectedIndex), y: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GalleryViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        selectedIndex = Int(floor(scrollView.contentOffset.x / scrollView.frame.width))
    }
}
