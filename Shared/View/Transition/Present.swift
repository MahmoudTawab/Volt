//
//  Present.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class ViewController : UIViewController  {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    SetCartCount()
    ViewNoData.removeFromSuperview()
    ViewDots.removeFromSuperview()
    view.addSubview(ViewNoData)
    view.addSubview(ViewDots)
    self.ViewDots.SpinnerView.startAnimating()
    
    ViewDots.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    ViewDots.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    ViewDots.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    ViewDots.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    ViewNoData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlWidth(20)).isActive = true
    ViewNoData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-20)).isActive = true
    ViewNoData.topAnchor.constraint(equalTo: view.topAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(130):ControlWidth(170)).isActive = true
    ViewNoData.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(-110):ControlWidth(-70)).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SetCartCount()
    }
    
    lazy var SearchBar : SearchBarView = {
        let View = SearchBarView()
        View.IconLeft = "Logo"
        View.IconRight = "scan"
        View.backgroundColor = .clear
        View.PlaceholderTF = "Search".localizable
        View.ShoppingButton.isUserInteractionEnabled = true
        View.SearchTF.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ScanQR)))
        View.ShoppingButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GoToCart)))
        View.RightIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ScanQR)))
        return View
    }()
    
    @objc func ScanQR() {
    Present(ViewController: self, ToViewController: ScanVC())
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .clear
        dismiss.ShoppingButton.isUserInteractionEnabled = true
        dismiss.ShoppingButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GoToCart)))
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }
    
    func SetUpDismiss(text:String ,ShowSearch:Bool = false , ShowShopping:Bool = false) {
        Dismiss.TextDismiss = text
        Dismiss.SearchIcon.isHidden = ShowSearch
        Dismiss.ShoppingButton.isHidden = ShowShopping
    }
    
    @objc func GoToCart() {
    Present(ViewController: self, ToViewController: CartVC())
    }
    
    
    var ArrayCount = [Int]()
    func SetCartCount() {
    SearchBar.ShoppingHub?.decrement()
    Dismiss.ShoppingHub?.decrement()
    DispatchQueue.main.async {
    self.ArrayCount.removeAll()
    if getUserObject().Uid == nil {
    if let ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    if ItemsArray.count == 0 {
    self.SearchBar.ShoppingHub?.setCount(0)
    self.Dismiss.ShoppingHub?.setCount(0)
    }else{
    ItemsArray.forEach { Item in
    if let ItemCount = Item["ItemCount"] as? Int {
    self.ArrayCount.append(ItemCount)
    self.SearchBar.ShoppingHub?.setCount(self.ArrayCount.sum())
    self.Dismiss.ShoppingHub?.setCount(self.ArrayCount.sum())
    }
    }
    }
    }
    }else{
    getCartObject()?.Items.forEach { Item in
    if let ItemCount = Item.ItemCount {
    self.ArrayCount.append(ItemCount)
    self.SearchBar.ShoppingHub?.setCount(self.ArrayCount.sum())
    self.Dismiss.ShoppingHub?.setCount(self.ArrayCount.sum())
    }
    }
    }
    }
    }
    
    lazy var ViewDots : DotsView = {
        let View = DotsView(frame: view.bounds)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.backgroundColor = .clear
        View.ViewPresent = self
        View.alpha = 0
        return View
    }()
    
    lazy var ViewNoData : ViewIsError = {
        let View = ViewIsError()
        View.backgroundColor = .clear
        View.isHidden = true
        View.TextRefresh = "Try Again".localizable
        View.ImageIcon = "ErrorService"
        View.MessageTitle = "Something went wrong".localizable
        View.MessageDetails = "Something went wrong while processing your request, please try again later".localizable
        View.translatesAutoresizingMaskIntoConstraints =  false
        return View
    }()
    
    var ViewNoDataShow = false
    func SetUpIsError(_ error:String ,_ Show:Bool ,_ selector: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.ViewDots.endRefreshing(){}
        }
        
        if !ViewNoDataShow {
        if Show {
        self.ViewNoDataShow = true
        self.ViewNoData.isHidden = false
        self.ViewNoData.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ViewNoData.transform = .identity})
        self.ViewNoData.RefreshButton.addAction(for: .touchUpInside) { (button) in
        selector()
        }
        }
        }
    }

}
