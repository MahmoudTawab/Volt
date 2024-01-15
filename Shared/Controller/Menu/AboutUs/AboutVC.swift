//
//  AboutVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 13/03/2022.
//

import UIKit
import SDWebImage

class AboutVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetAbout()
        view.addSubview(Dismiss)
        SetUpDismiss(text: "About Us".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
    }
    
    let AboutId = "About"
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .white
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(AboutCell.self, forCellReuseIdentifier: AboutId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    

    var AboutData = [About]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return AboutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutId, for: indexPath) as! AboutCell
        cell.selectionStyle = .none
        cell.LabelTitle.text = AboutData[indexPath.row].title
        cell.LabelBody.text = AboutData[indexPath.row].body
        cell.Image.sd_setImage(with: URL(string: AboutData[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }


    func SetAbout() {
//    guard let url = defaults.string(forKey: "API") else{return}
//        
//    let api = "\(url + AboutUs)"
//    let lang = "lang".localizable
//    let token = defaults.string(forKey: "JWT") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//        
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "lang": lang ,
//                                    "deviceID": udid]
//        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id" : "","title" : "About title 1","body" : "Here is what we have learned from Introduction to the Human Body","image" : "https://img.freepik.com/premium-vector/info-symbol-laptop-web-site-information-center-online-customer-support-useful-information_501813-1004.jpg"],
            ["id" : "","title" : "About title 1","body" : "Here is what we have learned from Introduction to the Human Body","image" : "https://img.freepik.com/premium-vector/world-map-geography-concept-tiny-people-study-atlas-earth-laptop-screen-globalisation_501813-397.jpg?size=626&ext=jpg"],
             ["id" : "","title" : "About title 1","body" : "Here is what we have learned from Introduction to the Human Body","image" : "https://img.freepik.com/premium-vector/photography-concept-photography-workshop-processing-workshop-photo-portfolio-creation-concept_501813-126.jpg?size=626&ext=jpg"],
            ["id" : "","title" : "About title 1","body" : "Here is what we have learned from Introduction to the Human Body","image" : "https://img.freepik.com/vector-premium/concepto-negocio-diseno-plano-moderno-comercializacion-utilizar-diseno-web_68094-83.jpg?size=626&ext=jpg"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            for item in data {
                self.AboutData.append(About(dictionary: item))
                self.TableView.SetAnimations()
            }
            
            self.ViewDots.endRefreshing{}
            self.ViewNoData.isHidden = true
            self.TableView.isHidden = false
            
        }
//    } Err: { error in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error,true) {self.SetAbout()}
//    }
    }
    
}
