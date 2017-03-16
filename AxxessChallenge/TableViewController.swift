//
//  TableViewController.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/13/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  RootViewController of the app
//  Contains a UITableView for displaying
//  Uses SegmentControl to switch from "All content", "Image only", and "Text only"
//  Heigts are calculated dynamically
//

import UIKit
import SnapKit

class TableViewController: UIViewController {

    //MARK: - Data
    var content = [Content](){
        didSet{
            tableView.reloadData()
        }
    }
    var imageContent = [Content](){
        didSet{
            tableView.reloadData()
        }
    }
    var textContent = [Content](){
        didSet{
            tableView.reloadData()
            
        }
    }
    
    //MARK: - View
    let segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["All", "Image", "Text"])
        segment.layer.cornerRadius = 5
        segment.frame = CGRect(x: 0, y: 0, width: 255, height: 30)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TableViewController.fetchData), for: .valueChanged)
        return refreshControl
    }()
    
    let nothingLabel: UILabel = {
        let nothingLabel = UILabel()
        nothingLabel.text = "No User Content Available"
        nothingLabel.isHidden = true
        return nothingLabel
    }()
    
    let tableView = UITableView()

    //MARK: - View config
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        segment.addTarget(self, action: #selector(TableViewController.changeContent), for: .valueChanged)
        
        self.navigationItem.titleView = segment
        //self.navigationItem.prompt = "User Content"
        
        view.addSubview(tableView)
        view.addSubview(nothingLabel)
        self.tableView.addSubview(refreshControl)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    init(){
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.white
        
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //reuse cell
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(ImageTableViewCell.self))
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextTableViewCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom func
    func fetchData(){
        RequestData.downloadJson(){ response in
            switch response{
            case .Error(let str):
                print("\(str)")
            case .Success(let content):
                self.content = content
                self.imageContent = self.getContent(type: .image)
                self.textContent = self.getContent(type: .text)
                print("success")
            }
        }
        refreshControl.endRefreshing()
    }
    func changeContent(){
        print("\(segment.selectedSegmentIndex)")
        tableView.reloadData()
    }
    func getContent(type: contentType) -> [Content]{
        var result = [Content]()
        for con in self.content{
            if con.type == type{
                result.append(con)
            }
        }
        return result
    }
}

//MARK: - Extensions
extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segment.selectedSegmentIndex){
        case 1:
            return imageContent.count
        case 2:
            return textContent.count
        default:
            return content.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tempContent = Content()
        switch segment.selectedSegmentIndex{
        case 1:
            tempContent = imageContent[indexPath.row]
        case 2:
            tempContent = textContent[indexPath.row]
        default:
            tempContent = content[indexPath.row]
        }
        
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let date = dateFormetter.string(from: tempContent.date!)
        
        if(tempContent.type == contentType.image){
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ImageTableViewCell.self), for: indexPath) as! ImageTableViewCell
            cell.setImage(url: tempContent.data!, date: date)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TextTableViewCell.self), for: indexPath) as! TextTableViewCell
            cell.setText(text: tempContent.data!, date: date)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(segment.selectedSegmentIndex){
        case 1:
            let tempContent = imageContent[indexPath.row]
            let vc = ImageViewController()
            vc.setImage(url: tempContent.data!)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let tempContent = textContent[indexPath.row]
            let vc = TextViewController()
            vc.setText(text: tempContent.data!)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let tempContent = content[indexPath.row]
            if tempContent.type == .image{
                let vc = ImageViewController()
                vc.setImage(url: tempContent.data!)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = TextViewController()
                vc.setText(text: tempContent.data!)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}
