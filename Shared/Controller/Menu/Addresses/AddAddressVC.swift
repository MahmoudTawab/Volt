//
//  AddAddressVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 12/03/2022.
//

import UIKit
import MapKit
import CoreLocation
import FlagPhoneNumber

class AddAddressVC: ViewController ,FPNTextFieldDelegate ,MKMapViewDelegate {
    
    var Checkout:CheckoutVC?
    var AddressesController : AddressesVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    if let Check = Checkout {
    Check.SetAddressDetails()
    }
    }
    
    fileprivate func SetUp() {
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Address".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
    let StackVertical = UIStackView(arrangedSubviews: [FullNameTF,PhoneNumberTF,StackCityAndArea,StreetNameTF,StackBuildingAndFloor,LandmarkTF])
    StackVertical.axis = .vertical
    StackVertical.spacing = ControlWidth(48)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .fill
    StackVertical.backgroundColor = .clear
    ViewScroll.addSubview(StackVertical)
    StackVertical.frame = CGRect(x: ControlX(15), y: ControlY(25) , width: view.frame.width - ControlX(30), height: ControlWidth(500))
        
    ViewScroll.addSubview(RefineLocation)
    RefineLocation.frame = CGRect(x: ControlX(15), y: StackVertical.frame.maxY  + ControlX(25) , width: view.frame.width - ControlX(30), height: ControlWidth(25))
        
    ViewScroll.addSubview(MapView)
    MapView.frame = CGRect(x: ControlX(15), y: RefineLocation.frame.maxY  + ControlX(15) , width: view.frame.width - ControlX(30), height: ControlWidth(160))
        
    ViewScroll.addSubview(SaveAddressButton)
    SaveAddressButton.frame = CGRect(x: ControlX(15), y: MapView.frame.maxY  + ControlX(30) , width: view.frame.width - ControlX(30), height: ControlWidth(50))
        
    lodDetails()
    SetUpPhoneNumber()
    SetCitiesAndAreas()
    ViewScroll.updateContentViewSize(ControlWidth(30))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.isHidden = true
        Scroll.backgroundColor = .white
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()

    lazy var FullNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Full name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
        
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Phone numbe".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(PhoneEditingDidEnd), for: .editingDidEnd)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1)
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code)
    }
    
    var isValidNumber = false
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    PhoneNumberTF.layer.borderColor = isValid ?  #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1).cgColor : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor
    PhoneNumberTF.PhoneLabel.alpha = isValid ? 0 : 1
    isValidNumber = isValid
    }
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country".localizable
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
        listController.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        listController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        listController.searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listController.searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true, completion: nil)
    }
    
    @objc func PhoneEditingDidEnd() {
    PhoneNumberTF.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1)
    PhoneNumberTF.PhoneLabel.alpha = 0
    }
    

    lazy var StackCityAndArea : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [CityTF,AreaTF])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    var CityAreas : CitiesOrAreas?
    lazy var CityTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = false
        tf.IconImage = UIImage(named: "Path")
        tf.font = UIFont(name: "Muli", size: ControlWidth(13))
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.Icon.addTarget(self, action: #selector(ActionCity), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionCity)))
        tf.attributedPlaceholder = NSAttributedString(string: "City".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    
    @objc func ActionCity() {
        CityAreas = .City
        SetUpDownView("City".localizable)
    }

    lazy var AreaTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = false
        tf.IconImage = UIImage(named: "Path")
        tf.font = UIFont(name: "Muli", size: ControlWidth(13))
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.Icon.addTarget(self, action: #selector(ActionArea), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionArea)))
        tf.attributedPlaceholder = NSAttributedString(string: "Area".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionArea() {
        CityAreas = .Areas
        SetUpDownView("Area".localizable)
    }
    
    lazy var StreetNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Street name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var StackBuildingAndFloor : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [BuildingNumberTF,FloorNumberTF])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var BuildingNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "Muli", size: ControlWidth(14))
        tf.attributedPlaceholder = NSAttributedString(string: "Building number".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var FloorNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.font = UIFont(name: "Muli", size: ControlWidth(14))
        tf.attributedPlaceholder = NSAttributedString(string: "Floor number".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var LandmarkTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Landmark".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var RefineLocation : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "Refine Location".localizable
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var MapView : MKMapView = {
        let View = MKMapView()
        View.delegate = self
        View.isZoomEnabled = false
        View.isScrollEnabled = false
        View.layer.cornerRadius = ControlWidth(20)
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionMapView)))
        return View
    }()
    
    @objc func ActionMapView() {
    let Location = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
    let Address = AddNewAddress()
    Address.AddAddress = self
    Address.LodLocation(Location: CoordinateLocation ?? Location)
    Present(ViewController: self, ToViewController: Address) 
    }
    

    var CoordinateLocation : CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    func LodLocation(Location:CLLocationCoordinate2D) {
    CoordinateLocation = Location
    MapView.removeAnnotations(MapView.annotations)
    let annotation = MKPointAnnotation()

    annotation.coordinate = Location
    let Geocoder = CLGeocoder()
    let location = CLLocation(latitude: Location.latitude, longitude: Location.longitude)
    Geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
    if let placemark = placemarks?.first {
    annotation.title = placemark.name
        
    if let city = placemark.locality,
    let state = placemark.administrativeArea {
    annotation.subtitle = "\(city) \(state)"
    }
    }
    })
    
    MapView.addAnnotation(annotation)
    let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
    let region = MKCoordinateRegion(center: Location, span: span)
    MapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        let image = UIImage(named: "Location")?.sd_tintedImage(with: UIColor.black)
        pinView?.image = image
        pinView?.canShowCallout = true
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        button.setImage(image, for: .normal)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }

    
    lazy var SaveAddressButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Save Address".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()

    var CityId :String?
    var AreaId :String?
    @objc func ActionSaveChanges() {
    if FullNameTF.NoError() && PhoneNumberTF.NoError() && isValidNumber && CityTF.NoError() && AreaTF.NoError() && StreetNameTF.NoError() && BuildingNumberTF.NoError() && FloorNumberTF.NoError() && LandmarkTF.NoError() {

    if Dismiss.TextDismiss == "Edit Address".localizable {
    ActionEditAddress()
    }else{
    ActionAddAddress()
    }
    }
    }
        
    var IndexEdit = IndexPath()
    func ActionEditAddress() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let uid = getUserObject().Uid else{return}
    guard let Name = FullNameTF.text else{return}
    guard let phone = PhoneNumberTF.text else{return}
    guard let streetName = StreetNameTF.text else{return}
    guard let buildingNumber = BuildingNumberTF.text else{return}
    guard let FloorNumber = FloorNumberTF.text else{return}
    guard let id = AddressesDetails?.id else{return}
    guard let Landmark = LandmarkTF.text else{return}
    guard let latitude = CoordinateLocation?.latitude else{return}
    guard let longitude = CoordinateLocation?.longitude else{return}

    guard let city = CityId else{return}
    guard let area = AreaId else{return}
    let lang = "lang".localizable
        
    let token = defaults.string(forKey: "JWT") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let api = "\(url + EditAddress)"
                                
    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                "Platform": "I",
                "uid": uid,
                "deviceID": udid,
                "addressId": id,
                "lang": lang,
                "Name": Name,
                "phone": phone,
                "city": city,
                "area": area,
                "streetName": streetName,
                "buildingNumber": buildingNumber,
                "floorNumber": FloorNumber,
                "landmark": Landmark,
                "lat": latitude,
                "lon": longitude]
                   
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.AddressesController?.AddressesData[self.IndexEdit.item] = Addresses(dictionary: data)
    self.AddressesController?.TableView.reloadRows(at: [self.IndexEdit], with: .automatic)
    self.ViewDots.endRefreshing("Success Edit Address".localizable, .success) {}
    
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.SetUpIsError(error,false) {self.ActionSaveChanges()}
    }
    }
    
    func ActionAddAddress() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let uid = getUserObject().Uid else{return}
    guard let Name = FullNameTF.text else{return}
    guard let phone = PhoneNumberTF.text else{return}
    guard let streetName = StreetNameTF.text else{return}
    guard let buildingNumber = BuildingNumberTF.text else{return}
    guard let FloorNumber = FloorNumberTF.text else{return}
    guard let Landmark = LandmarkTF.text else{return}
    guard let latitude = CoordinateLocation?.latitude else{return}
    guard let longitude = CoordinateLocation?.longitude else{return}

    guard let city = CityId else{return}
    guard let area = AreaId else{return}
    let lang = "lang".localizable
    let token = defaults.string(forKey: "JWT") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let api = "\(url + AddAddress)"
                            
    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
            "Platform": "I",
            "uid": uid,
            "deviceID": udid,
            "lang": lang,
            "Name": Name,
            "phone": phone,
            "city": city,
            "area": area,
            "streetName": streetName,
            "buildingNumber": buildingNumber,
            "floorNumber": FloorNumber,
            "landmark": Landmark,
            "lat": latitude,
            "lon": longitude]
                                 
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.AddressesController?.AddressesData.append(Addresses(dictionary: data))
    self.AddressesController?.TableView.reloadData()
    self.AddressesController?.SetUpNoContent()
    self.ViewDots.endRefreshing("Success Add Addres".localizable, .success) {}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.SetUpIsError(error,false) {self.ActionSaveChanges()}
    }
    }
    
    var CitiesAreas = [CitiesAndAreas]()
    func SetCitiesAndAreas() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let lang = "lang".localizable
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let api = "\(url + GetCitiesAndAreas)"
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "Platform": "I",
//                                   "lang": lang]
                 
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["id" : "","title" : "Cairo",
                    "Areas" : [
                        ["id" : "","title" : "Manshaet Naser"],
                        ["id" : "","title" : "El-Waily"],
                        ["id" : "","title" : "Wast El-Qahira"],
                        ["id" : "","title" : "Boulaq, Gharb El-Qahira"],
                        ["id" : "","title" : "Abdeen"]]],
        
                    ["id" : "","title" : "Alexandria",
                                "Areas" : [
                                    ["id" : "","title" : "Al Hadrah"],
                                    ["id" : "","title" : "Amreya"],
                                    ["id" : "","title" : "Anfoushi"],
                                    ["id" : "","title" : "Azarita"],
                                    ["id" : "","title" : "Alexandria"]]],
        
                    ["id" : "","title" : "Giza",
                                "Areas" : [
                                    ["id" : "","title" : "Jobat wa eqshak"],
                                    ["id" : "","title" : "Ziby kinder"],
                                    ["id" : "","title" : "zahraa el maadi normal"],
                                    ["id" : "","title" : "hangout spots and spotat"],
                                    ["id" : "","title" : "coolest people on earth"]]],
        
                    ["id" : "","title" : "Shubra El Kheima",
                                "Areas" : [
                                    ["id" : "","title" : "Test Areas 1"],
                                    ["id" : "","title" : "Test Areas 2"],
                                    ["id" : "","title" : "Test Areas 3"],
                                    ["id" : "","title" : "Test Areas 4"],
                                    ["id" : "","title" : "Test Areas 5"]]]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
        for item in data {
        self.CitiesAreas.append(CitiesAndAreas(dictionary: item))
        self.PickerCitiesAreas.reloadAllComponents()
        }
            
        self.ViewScroll.isHidden = false
        self.ViewNoData.isHidden = true
        self.ViewDots.endRefreshing(){}
        }
//    } Err: { error in
//    self.ViewScroll.isHidden = true
//    self.SetUpIsError(error,true) {self.SetCitiesAndAreas()}
//    }
    }
    
    let PickerCitiesAreas = UIPickerView()
    @objc func SetUpDownView(_ text:String) {
    let PopUp = PopUpDownView()
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(260)
    PopUp.radius = 25

    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.text = text
    Label.textAlignment = .center
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Muli-SemiBold" ,size: ControlWidth(20))
    PopUp.View.addSubview(Label)
    Label.frame = CGRect(x: ControlWidth(15), y: ControlWidth(15), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    PickerCitiesAreas.delegate = self
    PickerCitiesAreas.backgroundColor = .clear
    PopUp.View.addSubview(PickerCitiesAreas)
    PickerCitiesAreas.frame = CGRect(x: ControlWidth(15), y: Label.frame.maxY + ControlX(5), width: PopUp.view.frame.width - ControlWidth(30), height: ControlWidth(200))
    present(PopUp, animated: true)
    }

    var AddressesDetails : Addresses?
    func lodDetails() {
    if let Details = AddressesDetails {
    FullNameTF.text = Details.Name
    PhoneNumberTF.text = Details.phone
    StreetNameTF.text = Details.streetName
    BuildingNumberTF.text = Details.buildingNumber
    FloorNumberTF.text = Details.floorNumber
    LandmarkTF.text = Details.landmark
    CityTF.text = Details.city?.title ?? ""
    AreaTF.text = Details.area?.title ?? ""
    CityId = Details.city?.id ?? ""
    AreaId = Details.area?.id ?? ""
        
    let Location = CLLocationCoordinate2D(latitude: Details.lat?.toDouble() ?? 0.0, longitude: Details.lon?.toDouble() ?? 0.0)
    CoordinateLocation = Location
    LodLocation(Location:Location)
    }else{
    LocationNil()
    }
    }
    
    func LocationNil() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        MapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }

}

extension AddAddressVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
    locationManager.requestLocation()
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            MapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

public enum CitiesOrAreas {
    case City,Areas
}

extension AddAddressVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityAreas == .City ? CitiesAreas.count : CitiesAreas[component].Areas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityAreas == .City ? CitiesAreas[row].title : CitiesAreas[component].Areas[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if CityAreas == .City {
        CityTF.text = CitiesAreas[row].title
        CityId = CitiesAreas[row].id
        }else{
        AreaTF.text = CitiesAreas[component].Areas[row].title
        AreaId = CitiesAreas[component].Areas[row].id
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label:UILabel
        if let view = view as? UILabel {
            label = view
        }else{
            label = UILabel()
        }
        label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Muli-Bold", size: ControlWidth(16))
        label.text = CityAreas == .City ? CitiesAreas[row].title : CitiesAreas[component].Areas[row].title
        return label
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return ControlWidth(35)
    }
}

