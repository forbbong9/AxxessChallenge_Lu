//
//  ImageTableViewCell.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/13/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Image Cell for tableview of TableViewController.
//

import UIKit
import SnapKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        dateLabel.textColor = UIColor.gray
        return dateLabel
    }()
    
    let anImageView: UIImageView = {
        let anImageView = UIImageView()
        anImageView.contentMode = .scaleAspectFit
        return anImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(anImageView)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        anImageView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.snp.makeConstraints{(make) in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(8)
        }
        
        anImageView.snp.makeConstraints{ (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(32, 0, 0, 0))
            make.height.lessThanOrEqualTo(255)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(url: String, date: String){
        let url = URL(string: url)
        //some images may have error, use placeholder instead
        anImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        
        dateLabel.text = date
    }
    
    

}
