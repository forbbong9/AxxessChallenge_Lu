//
//  ImageViewController.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/14/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Class to display single image.
//

import UIKit
import Kingfisher
import SnapKit

class ImageViewController: UIViewController {
    
    var hidden = false{
        didSet{
            if let nav = navigationController{
                nav.setNavigationBarHidden(hidden, animated: true)
                view.backgroundColor = hidden ? UIColor.black : UIColor.white
            }
        }
    }
    
    var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        return tap
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - View config
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Full Image"
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(imageView)
        tapGesture.addTarget(self, action: #selector(ImageViewController.tapImage(sender:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints{(make) in
                    make.edges.equalTo(view).inset(UIEdgeInsetsMake(20, 0, 0, 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(url: String){
        imageView.kf.setImage(with: URL(string: url), placeholder: #imageLiteral(resourceName: "placeholder"))
    }

    func tapImage(sender: UIGestureRecognizer){
        if(sender.state == .ended){
            hidden = !hidden
        }
    }
}
