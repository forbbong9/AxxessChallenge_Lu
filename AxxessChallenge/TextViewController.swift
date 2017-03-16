//
//  TextViewController.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/14/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Class to display full text.
//  Uses scrollable textview without editable
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Full Text"
        
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.snp.makeConstraints{(make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(20, 20, 20, 20))
        }
    }
    
    func setText(text: String){
        textView.text = text
    }

}
