//
//  APIFunc.swift
//  APIFunc
//
//  Created by Emoji Technology on 27/09/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseStorage

    func PostAPI(api:String ,token:String?
                 , parameters:[String:Any]
                 ,string: @escaping ((String) -> Void)
                 , DictionaryData: @escaping (([String: Any]) -> Void)
                 , ArrayOfDictionary: @escaping (([[String: Any]]) -> Void)
                 , Err: @escaping ((String) -> Void)) {
        
        
    guard let Url = URL(string:api) else {return}
    var request = URLRequest(url: Url)
    request.httpMethod = "POST"
    request.timeoutInterval = 30
        
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    if let Token = token {
    request.setValue( "Bearer \(Token)", forHTTPHeaderField: "Authorization")
    }

    do {
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
    Err(error.localizedDescription)
    return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else {
    if let error = error {
    DispatchQueue.main.async {
    Err(StatusCodes(-1001, "\n" + error.localizedDescription))
    }
    }
    return
    }
       
    
    do {
    guard let response = response as? HTTPURLResponse else {return}
    if response.statusCode != 200 {
    if response.statusCode != 406 {
    DispatchQueue.main.async {
    Err(StatusCodes(response.statusCode))
    }
    }else{
    if response.statusCode == 406 {
    if let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    let Messag = Array["Messag"] as? String ?? "Sorry, unable to connect to the server"
    DispatchQueue.main.async {
    Err(StatusCodes(406, "ERROR MESSAG" + "\n" + Messag))
    }
    }
    }
    }
    return
    }
        
    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    DictionaryData(dictionary)
    }
    }
        
    if let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    ArrayOfDictionary(array)
    }
    }
      
    if let strContent = String(data: data, encoding: .utf8) {
    DispatchQueue.main.async {
    string(strContent)
    }
    }
        
    }catch{
    return
    }
    }.resume()
    }

  func StatusCodes(_ Status:Int ,_ Messag:String = "") -> String {

    switch Status {

        ///
    case 204:
    return "No Content".localizable
        
       ///
    case 400:
    return "Bad Request".localizable
       
       ///
    case 401:
    UpDateToken()
    return "Unauthorized".localizable
        
    ///
    case 404:
    return "Not Found".localizable
        
    ///
    case 406:
    return Messag
        
    ///
    case -1001:
    return Messag
       
    default:
    break
    }

    return ""
    }

   func UpDateToken() {
   guard let url = defaults.string(forKey: "API") else{return}
   let api = "\(url + AddDevice)"
   
   let lang = "lang".localizable
   let modelName = UIDevice.modelName
   let version = UIDevice.current.systemVersion
   let fireToken = defaults.string(forKey: "fireToken") ?? ""
   let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
           
   let parameters:[String:Any] = ["token": "07XkreQli3noSErCb_J7r3i4C9mTfsM_bf-7q8v2ikg",
                                  "lang": lang,
                                  "fireToken": fireToken,
                                  "deviceID": udid,
                                  "deviceModel": modelName,
                                  "manufacturer": "IOS",
                                  "osVersion": version,
                                  "versionCode": "1"]
        
    PostAPI(api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    var _ = JWT(dictionary: data)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    print(error)
    }
   }


  func ShowMessageAlert(_ IconTitle:String ,_ Title:String ,_ Message:String,_ DoneisHidden:Bool ,_ selector: @escaping () -> Void ,_ ButtonText : String = "Try Again".localizable) {
        
    if var topController = UIApplication.shared.keyWindow?.rootViewController  {
    while let presentedViewController = topController.presentedViewController {
    topController = presentedViewController
    }
    
    let Controller = PopUpCenterView()
    Controller.MessageTitle = Title
    Controller.MessageDetails = Message
    Controller.ImageIcon = IconTitle
    Controller.RightButtonText = ButtonText
    Controller.StackIsHidden = false
    Controller.RightButton.isHidden = DoneisHidden

    Controller.RightButton.addAction(for: .touchUpInside) { (button) in
    selector()
    }
    
    Controller.modalPresentationStyle = .overFullScreen
    Controller.modalTransitionStyle = .crossDissolve
    topController.present(Controller, animated: true, completion: nil)
    }
    }


    func StoragArray(child:[String] , image: [UIImage] , completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {
    for Image in image {
    guard let data = Image.jpegData(compressionQuality: 0.75) else {return}
    var storage = Storage.storage().reference().child(child[0]).child(child[1]).child("\(data)")
                
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    }
    }

    func Storag(child:[String] , image: UIImage, completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {

    var storage = Storage.storage().reference().child(child[0]).child(child[1]).child(child[1])
    
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    guard let data = image.jpegData(compressionQuality: 0.75) else {return}
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    }

