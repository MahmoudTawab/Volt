//
//  AddNewAddress.swift
//  MapKitFinder
//  Created by Minh Nguyen on 05/07/2021.
//  Copyright © 2021 Minh Nguyen. All rights reserved.
//


import UIKit
import MapKit
import Foundation

class AddNewAddress : UIViewController {
    
    var AddAddress:AddAddressVC?
    var matchingItems:[MKMapItem] = []
    var locationManager = CLLocationManager()
    var centerAnnotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        SetUp()
    }
    
    func SetUp() {
    
        view.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
            
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
        view.addSubview(ButtonCenter)
        ButtonCenter.frame = CGRect(x: view.frame.maxX - ControlX(70), y: view.frame.maxY - ControlX(160) , width: ControlWidth(60), height: ControlWidth(60))
        
        view.addSubview(ConfirmLocation)
        ConfirmLocation.frame = CGRect(x: ControlX(15), y: view.frame.maxY  - ControlX(80) , width: view.frame.width - ControlX(30), height: ControlWidth(50))
        
        view.addSubview(LocationSearchTable)
        
        view.addSubview(ResultSearch)
        ResultSearch.frame = CGRect(x: ControlX(20), y: Dismiss.frame.maxY + ControlY(30), width: view.frame.width - ControlX(40), height: ControlWidth(50))

        
        LocationSearchTable.layer.cornerRadius = ControlWidth(16)
        locationManager.delegate = self
    }
        
    func LodLocation(Location:CLLocationCoordinate2D) {
    mapView.removeAnnotations(mapView.annotations)
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
        
    mapView.addAnnotation(annotation)
    let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
    let region = MKCoordinateRegion(center: Location, span: span)
    mapView.setRegion(region, animated: true)
    }
    
    lazy var Dismiss : ViewDismiss = {
        let dismiss = ViewDismiss()
        dismiss.backgroundColor = .white
        dismiss.TextDismiss = "Add Address".localizable
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }
    
    lazy var ResultSearch : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.layer.borderWidth = 0
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.IconImage = UIImage(named: "Location")?.sd_tintedImage(with: UIColor.black)
        tf.font = UIFont(name: "Muli", size: ControlWidth(13))
        tf.SetUpIcon(LeftOrRight: true, Width: 20, Height: 24)
        tf.addTarget(self, action: #selector(updateSearchResults), for: .editingChanged)
        tf.attributedPlaceholder = NSAttributedString(string: "Area name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func updateSearchResults() {
        UIView.animate(withDuration: 0.3) {
        if self.ResultSearch.NoError() {
        self.LocationSearchTable.alpha = 1
        }else{
        self.LocationSearchTable.alpha = 0
        self.LocationSearchTable.frame = CGRect(x: ControlX(20), y: self.ResultSearch.frame.midY, width: self.view.frame.width - ControlX(40), height: 0)
        }
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = ResultSearch.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
  
            self.matchingItems = response.mapItems
            self.LocationSearchTable.reloadData()
            
            let height = (CGFloat(response.mapItems.count) * ControlWidth(50)) + ControlWidth(40)
            let TableHeight = height < ControlWidth(200) ? height : ControlWidth(200)
            self.LocationSearchTable.frame = CGRect(x: ControlX(20), y: self.ResultSearch.frame.midY , width: self.view.frame.width - ControlX(40), height: TableHeight)

        }
    }
    
    lazy var LocationSearchTable : UITableView = {
        let tv = UITableView()
        tv.alpha = 0
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = ControlWidth(50)
        tv.separatorInset = UIEdgeInsets(top: 0, left: ControlX(15), bottom: 0, right: 0)
        tv.contentInset = UIEdgeInsets(top: ControlWidth(40), left: 0, bottom: 0, right: 0)
        tv.register(LocationSearchCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    lazy var mapView : MKMapView = {
        let View = MKMapView()
        View.delegate = self
        View.backgroundColor = .white
        return View
    }()
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "5"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "1" and "2"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    func dropPinZoomIn(placemark:MKPlacemark) {
 
        ResultSearch.text = placemark.name
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name

        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    lazy var ButtonCenter : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "Group 25324"), for: .normal)
        Button.addTarget(self, action: #selector(ActionCenter), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionCenter() {
    mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    lazy var ConfirmLocation : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitleColor(.black, for: .normal)
        Button.setTitle("Confirm Location".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionConfirmLocation), for: .touchUpInside)
        return Button
    }()
    
    var CoordinateLocation : CLLocationCoordinate2D?
    @objc func ActionConfirmLocation() {
    if let selected = CoordinateLocation {
    AddAddress?.LodLocation(Location: selected)
    self.navigationController?.popViewController(animated: true)
    }else{
    self.navigationController?.popViewController(animated: true)
    }
    }
        
}

extension AddNewAddress : CLLocationManagerDelegate {
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
        let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}


extension AddNewAddress : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        let reuseId = "Identifier"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        let image = UIImage(named: "Location")?.sd_tintedImage(with: UIColor.red)
        pinView?.image = image
        pinView?.canShowCallout = true
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    mapView.removeAnnotations(mapView.annotations)
    let annotation = MKPointAnnotation()
    annotation.coordinate = mapView.centerCoordinate
        
    let Geocoder = CLGeocoder()
    let Location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    Geocoder.reverseGeocodeLocation(Location, completionHandler: {(placemarks, error) -> Void in
    if let placemark = placemarks?.first {
    annotation.title = placemark.name
    self.ResultSearch.text = placemark.name
        
    if let city = placemark.locality,
    let state = placemark.administrativeArea {
    annotation.subtitle = "\(city) \(state)"
    }
    }
    })
  
    UIView.animate(withDuration: 0.4) {
    mapView.addAnnotation(annotation)
    self.centerAnnotation.coordinate = mapView.centerCoordinate;
    self.mapView.addAnnotation(self.centerAnnotation)
    }
        
    CoordinateLocation = mapView.centerCoordinate;
    }
}

extension AddNewAddress : UITableViewDelegate ,UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return matchingItems.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationSearchCell
    let selectedItem = matchingItems[indexPath.row].placemark
    cell.TextLabel.text = selectedItem.name
    cell.DetailTextLabel.text = parseAddress(selectedItem: selectedItem)
    return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = matchingItems[indexPath.row].placemark
    dropPinZoomIn(placemark: selectedItem)
    UIView.animate(withDuration: 0.3) {
    self.LocationSearchTable.alpha = 0
    self.ResultSearch.resignFirstResponder()
    }
   }
}
