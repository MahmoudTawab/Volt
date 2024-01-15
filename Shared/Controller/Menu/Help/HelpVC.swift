//
//  HelpVC.swift
//  Bnkit
//
//  Created by Mohamed Tawab on 05/02/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit

class HelpVC: ViewController , UITableViewDelegate , UITableViewDataSource {
    
    let HelpId = "Help"
    var HelpData = [Help]()
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    }

    fileprivate func SetUpTableView() {
    view.backgroundColor = .white
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Help".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))

    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
    SetHelpData()
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.rowHeight = UITableView.automaticDimension
        tv.register(HelpCell.self, forCellReuseIdentifier: HelpId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HelpData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpId, for: indexPath) as! HelpCell
        cell.selectionStyle = .none
        
        cell.TextTitle.text = HelpData[indexPath.row].question
        cell.TheDetails.text = HelpData[indexPath.row].answer
        cell.TheDetails.isHidden = HelpData[indexPath.row].HelpHidden
        cell.OpenClose.transform = HelpData[indexPath.row].HelpHidden == false ? .identity:CGAffineTransform(rotationAngle: -.pi / 2)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    HelpData[indexPath.row].HelpHidden = !HelpData[indexPath.row].HelpHidden
    TableView.reloadRows(at: [indexPath], with: .automatic)
    TableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    func SetHelpData(removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{return}
//        
//    let api = "\(url + GetFAQs)"
//    let lang = "lang".localizable
//    let token = defaults.string(forKey: "JWT") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//        
//    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "platform": "I",
//                                   "lang": lang,
//                                   "deviceID": udid,
//                                   "take": 5,
//                                   "skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id":"","question":"Test question 1","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 2","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 3","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 4","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 5","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 6","answer":"Here is what we have learned from Introduction to the Human Body"],
                    ["id":"","question":"Test question 7","answer":"Here is what we have learned from Introduction to the Human Body"]]
        
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            
            if removeAll {
                self.TableView.RemoveAnimations {
                    self.HelpData.removeAll()
                    self.Animations = true
                    self.AddData(data:data)
                }
            }else{
                self.AddData(data:data)
            }
            
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
            self.TableView.isHidden = false
            
        }
//    } Err: { error in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
    }
    
    func AddData(data:[[String:Any]]) {
    for item in data {
    self.HelpData.append(Help(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.TableView.SetAnimations() {self.Animations = false} : self.TableView.reloadData()
    }
    }
    
    
    @objc func refresh() {
    skip = 0
    SetHelpData(removeAll: true)
    }
    
}

extension HelpVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetHelpData(removeAll: false, ShowDots: false)
        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more".localizable
        case let .loading(completionHandler):
        pullLoadView.messageLabel.text = "Updating".localizable
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}
