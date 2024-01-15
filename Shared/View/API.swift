//
//  API.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 05/12/2021.
//


import FirebaseFirestore

    let defaults = UserDefaults.standard

    func LodBaseUrl()  {
    Firestore.firestore().collection("API").document("IOS").addSnapshotListener { (querySnapshot, err) in
    if let err = err {
    print(err.localizedDescription)
    return
    }
    guard let data = querySnapshot?.data() else {return}
    DispatchQueue.main.async {
    let DebugBase = data["DebugBaseUrl"] as? String
    let ReleaseBase = data["ReleaseBaseUrl"] as? String
    let WhatsApp = data["WhatsAppNumber"] as? String
        
    defaults.set(DebugBase, forKey: "API")
    defaults.set(ReleaseBase, forKey: "Url")
    defaults.set(WhatsApp, forKey: "WhatsApp")
    }
    }
    }


    ///
///
    var GUID = "00000000-0000-0000-0000-000000000000"
///
    let AddDevice = "Phone/AddDevice"

    let login = "Phone/login"

    let loginSocial = "Phone/loginSocial"

    let SendSms = "Phone/SendSms"

    let CreateNewAccount = "Phone/CreateNewAccount"

    let GetMainScreen = "Phone/GetMainScreen"

    let GetCategories = "Phone/GetCategories"

    let GetOffers = "Phone/GetOffers"

    let GetProfile = "Phone/GetProfile"

    let EditProfile = "Phone/EditProfile"

    let GetItemDetails = "Phone/GetItemDetails"

    let GetItems = "Phone/GetItems"

    let AddItemFavourite = "Phone/AddItemFavourite"

    let RemoveItemFavourite = "Phone/RemoveItemFavourite"

    let GetWishList = "Phone/GetWishList"

    let GetItemReviews = "Phone/GetItemReviews"

    let GetFAQs = "Phone/GetFAQs"

    let AddContactUs = "Phone/AddContactUs"

    let UpdateReceiveNotifications = "Phone/UpdateReceiveNotifications"

    let GetAddresses = "Phone/GetAddresses"

    let DeleteAddresses = "Phone/DeleteAddresses"

    let ChangeDefaultAddress = "Phone/ChangeDefaultAddress"

    let GetCitiesAndAreas = "Phone/GetCitiesAndAreas"

    let AddAddress = "Phone/AddAddress"

    let  GetDefaultAddressDetails = "Phone/GetDefaultAddressDetails"

    let EditAddress = "Phone/EditAddress"

    let GetCompareItems = "Phone/GetCompareItems"

    let AboutUs = "Phone/AboutUs"

    let UpdateCartItem = "Phone/UpdateCartItem"

    let GetCartDetails = "Phone/GetCartDetails"

    let GetRecentlyViewed = "Phone/GetRecentlyViewed"

    let ChangeSizeOrColor = "Phone/ChangeSizeOrColor"

    let NotifyOutOfStock = "Phone/NotifyOutOfStock"

    let GetFilter = "Phone/GetFilter"
