//
//  ItemReviewsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 11/03/2022.
//

import UIKit

class ItemReviewsVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    var itemId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(Dismiss)
        SetUpDismiss(text: "Item Reviews".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))

        view.addSubview(TableView)
        TableView.frame = CGRect(x: ControlX(5), y: Dismiss.frame.maxY + ControlY(5), width: view.frame.width - ControlX(10), height: view.frame.height - ControlHeight(80))
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        TableView.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        TableView.addPullLoadableView(loadMoreView, type: .loadMore)
                    
        SetItemReviews()
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .white
        tv.showsVerticalScrollIndicator = false
        tv.rowHeight = UITableView.automaticDimension
        tv.register(ReviewsCommentCell.self, forCellReuseIdentifier: "CellComment")
        tv.contentInset = UIEdgeInsets(top: ControlY(10), left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCell(withIdentifier: "CellComment", for: indexPath) as! ReviewsCommentCell
    Cell.selectionStyle = .none
    Cell.LabelName.text = AllReviews[indexPath.row].userName
    Cell.ViewRating.rating = AllReviews[indexPath.row].rat?.toDouble() ?? 1
    Cell.Comment.text = AllReviews[indexPath.row].Review
    Cell.LabelDate.text = AllReviews[indexPath.row].date?.Formatter().Formatter("d MMM, yyyy")
    return Cell
    }

    var SkipItems = 0
    var ItemsMore = false
    var Animations = true
    var AllReviews = [ItemReviews]()
    func SetItemReviews(removeAll:Bool = false,ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    guard let Id = itemId else{return}
//    let uid = getUserObject().Uid ?? ""
//            
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let api = "\(url + GetItemReviews)"
//            
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "Platform": "I",
//                                   "lang": lang,
//                                   "uid": uid,
//                                   "deviceID": udid,
//                                   "itemId": Id,
//                                   "take": 10,
//                                   "skip": SkipItems]
//                
    ItemsMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id" : "","Review" : "The phone is great. Battery life, speed, camera and all very good","userName" : "Mahmoud","rat" : "3.5","date" : "2024-01-01T10:00:00"],
                    
                    ["id" : "","Review" : "I bought the iPhone 14 as a gift for my moms birthday as she needed an upgrade badly and she really loves the new phone as she is currently using it for her work and she is much more productive now. I highly recommend this phone for anybody who needs a new upgrade and has the money to spend on this phone.","userName" : "Someone","rat" : "3.5","date" : "2024-01-03T10:00:00"],
                            
                    ["id" : "","Review" : "Camera UI (5/5): One thing I really liked is the Photographic Styles (basically tunes the colors) when taking photos. There are a few preset filters like Standard, Rich Contrast, Vibrant, Warm, and Cool. You can tune one them and make it your default setting.","userName" : "Mohammad M.","rat" : "3.5","date" : "2024-01-10T10:00:00"],
                            
                    ["id" : "","Review" : "Main Camera 5/5: It takes quite good shots, whether it is in a well lit environment or a dark room. Videos are also great with it. One thing iPhones are good at is zooming smoothly while taking videos. I can't take a video without zooming at least once during the video, it is that mesmerizing. ","userName" : "Maureen Kimaru","rat" : "4.5","date" : "2024-01-09T10:00:00"] ,
                            
                    ["id" : "","Review" : "Selfie Camera (3/5): When I first bought the phone, I struggled at least a week with it. Then it got fixed with the most recent update. The focus point seemed to be fixed at far objects, so your face would always be out of focus. After the fix, I still find that it over sharpens my facial features and skin marks to the point that it shows stuff that do not seem to be there (at least when I look in the mirror).","userName" : "Tawab","rat" : "2.5","date" : "2024-01-04T10:00:00"],
                            
                    ["id" : "","Review" : "Ultra Wide Camera (0/5): Photos with this camera is underwhelming and extremely horrible. The noise is just horrible with this one, everything looks grainy. I put it next to a Samsung A31 and took a picture in the same exact conditions, and the A31 was leagues ahead!!! You can get to the nearest store, grab an iPhone14 and another Samsung/Oppo/OnePlus phone, even the budget ones, and take the same exact picture from the same angle, and compare them, and I am sure you will spot a huge difference.","userName" : "Hosny","rat" : "4.2","date" : "2024-01-12T10:00:00"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            if removeAll {
            self.TableView.RemoveAnimations {
            self.AllReviews.removeAll()
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

        
        
//    }Err: { error in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error,true) {self.SetItemReviews()}
//    }
    }
    
    func AddData(data:[[String:Any]]) {
    for item in data {
    self.AllReviews.append(ItemReviews(dictionary: item))
    self.SkipItems += 1
    self.ItemsMore = false
    self.Animations == true ? self.TableView.SetAnimations() {self.Animations = false} : self.TableView.reloadData()
    }
    }
    
    @objc func RefreshItemReviews() {
    SkipItems = 0
    SetItemReviews(removeAll: true, ShowDots: true)
    }

}

extension ItemReviewsVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {

        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetItemReviews(ShowDots: false)
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
        self.RefreshItemReviews()
        }
        }
        return
        }
}
