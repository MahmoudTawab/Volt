//
//  ScanVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 03/01/2022.
//

import UIKit
import AVFoundation

class ScanVC: ViewController {

    var audio:AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetUp()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.QRScanner.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FlashButton.tag = 0
        FlashButton.setImage(UIImage(named: "FlashOFF"), for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.QRScanner.stopRunning()
    }
    
    func SetUp() {
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Scan QR".localizable, ShowSearch: true, ShowShopping: false)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
    view.addSubview(QRScanner)
    view.addSubview(FlashButton)
    FlashButton.frame = CGRect(x: view.center.x - ControlWidth(30), y: QRScanner.frame.maxY - ControlWidth(80), width: ControlWidth(60), height: ControlWidth(60))
        
    view.addSubview(ScanQRLabel)
    ScanQRLabel.frame = CGRect(x: ControlX(15), y: QRScanner.frame.maxY + ControlY(30), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        
    view.addSubview(ScanQRDetails)
    ScanQRDetails.frame = CGRect(x: ControlX(15), y: ScanQRLabel.frame.maxY + ControlY(10), width: view.frame.width - ControlX(30), height: ControlWidth(60))
    }

    lazy var QRScanner : QRScannerView = {
        let View = QRScannerView(frame: CGRect(x: ControlX(40), y: ControlY(100), width: view.frame.width - ControlX(80), height: ControlWidth(300)))
        View.focusImage = UIImage(named: "ScanQR")
        View.focusImagePadding = 8.0
        View.animationDuration = 0.5
        View.configure(delegate: self)
        View.startRunning()
        return View
    }()

    lazy var FlashButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tag = 0
        Button.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.5)
        Button.setImage(UIImage(named: "FlashOFF"), for: .normal)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.titleLabel?.textAlignment = .center
        Button.layer.cornerRadius = ControlWidth(30)
        Button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        Button.addTarget(self, action: #selector(tapFlashButton(_:)), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func tapFlashButton(_ sender: UIButton) {
    sender.tag = sender.tag == 0 ? 1:0
    QRScanner.setTorchActive(isOn: sender.tag == 0 ? false : true)
    FlashButton.setImage(sender.tag == 0 ? UIImage(named: "FlashOFF") : UIImage(named: "FlashON"), for: .normal)
    }
    
    
    lazy var ScanQRLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Label.textAlignment = .center
        Label.text = "Scan QR code".localizable
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(20))
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var ScanQRDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(18))
        Label.text = "Place the product QR code inside the camera, in order to scan it".localizable
        return Label
    }()
}


// MARK: - QRScannerViewDelegate
extension ScanVC: QRScannerViewDelegate {
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

        let alertController = UIAlertController(title: "Error".localizable, message: error.localizedDescription, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel".localizable, style: .cancel, handler: { [weak self] _ in
            self?.QRScanner.rescan()
        })
        alertController.view.tintColor = .black
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String, isBarcode: Bool) {
        guard let url = Bundle.main.url(forResource: "barcode", withExtension: "mp3") else { return }
        do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        audio = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = audio else { return }
        player.play()
        player.volume = 1
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FlashButton.tag = 0
        FlashButton.setImage(UIImage(named: "FlashOFF"), for: .normal)
        } catch let error {
        print(error.localizedDescription)
        }
        
//        if let url = URL(string: code), (url.scheme == "http" || url.scheme == "https") {
//            openWeb(url: url)
//        } else {
            showAlert(code: code, isBarcode: isBarcode)
//        }
    }
    
}

// MARK: - Private
private extension ScanVC {
    func openWeb(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: { [weak self] _ in
            self?.QRScanner.rescan()
        })
    }

    func showAlert(code: String, isBarcode: Bool) {
        let preferredStyle = UIDevice.current.userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet:UIAlertController.Style.alert
        let alertController = UIAlertController(title: code, message: nil, preferredStyle: preferredStyle)
        let copyAction = UIAlertAction(title: "Copy".localizable, style: .default) { [weak self] _ in
            UIPasteboard.general.string = code
            self?.QRScanner.rescan()
        }
        alertController.addAction(copyAction)
        let searchWebAction = UIAlertAction(title: "Search".localizable, style: .default) { [weak self] _ in
            self?.ProductDetails(isBarcode: isBarcode, code: code)
        }
        alertController.addAction(searchWebAction)
        let cancelAction = UIAlertAction(title: "Cancel".localizable, style: .cancel, handler: { [weak self] _ in
            self?.QRScanner.rescan()
        })
        alertController.view.tintColor = .black
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func ProductDetails(isBarcode:Bool ,code:String)  {
//        code
//        isBarcode
    let ProductDetails = ProductDetailsVC()
    ProductDetails.GetProduct(isBarcode: true ,barcode: "6223001241553")
    Present(ViewController: self, ToViewController: ProductDetails)
    self.QRScanner.rescan()
    }
}
