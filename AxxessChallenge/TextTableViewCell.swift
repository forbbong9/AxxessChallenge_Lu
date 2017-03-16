//
//  TextTableViewCell.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/13/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Text Cell for tableview of TableViewController.
//

import UIKit
import SnapKit

class TextTableViewCell: UITableViewCell {

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        dateLabel.textColor = UIColor.gray
        return dateLabel
    }()
    var aTextLabel: UILabel = {
        let aTextlabel = UILabel()
        aTextlabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold)
        aTextlabel.numberOfLines = 0
        return aTextlabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(aTextLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        aTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.snp.makeConstraints{(make) in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(8)
        }
        
        aTextLabel.snp.makeConstraints{ (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(20, 20, 8, 20))
            make.height.lessThanOrEqualTo(140)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String, date: String){
        //remove linebreak at the begining
        aTextLabel.text = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
        
        dateLabel.text = date
    }

}
