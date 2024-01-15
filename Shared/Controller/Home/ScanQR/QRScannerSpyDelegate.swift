//
//  SpyDelegate.swift
//  QRScannerTests
//
//  Created by daichiro on 2019/11/25.
//  Copyright © 2019 mercari.com. All rights reserved.
//


import Foundation
import AVFoundation

protocol QRScannerSpyDelegateResult: AnyObject {
    var didFailure: (QRScannerError) -> Void { get set }
    var didSuccess: (String) -> Void { get set }
    var didChangeTorchActive: (Bool) -> Void { get set }
}

protocol QRScannerSpyDelegateResultType: AnyObject {
    var result: QRScannerSpyDelegateResult { get set }
}

class QRScannerSpyDelegate: QRScannerViewDelegate, QRScannerSpyDelegateResultType, QRScannerSpyDelegateResult {

    var result: QRScannerSpyDelegateResult {
        get { return self }
        set { self.result = newValue }
    }
    var didFailure: (QRScannerError) -> Void = { _ in }
    var didSuccess: (String) -> Void = { _ in }
    var didChangeTorchActive: (Bool) -> Void = { _ in }

    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        result.didFailure(error)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String , isBarcode: Bool) {
        result.didSuccess(code)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didChangeTorchActive isOn: Bool) {
        result.didChangeTorchActive(isOn)
    }
}



public enum QRScannerError: Error {
    case unauthorized(AVAuthorizationStatus)
    case deviceFailure(DeviceError)
    case readFailure
    case unknown

    public enum DeviceError {
        case videoUnavailable
        case inputInvalid
        case metadataOutputFailure
        case videoDataOutputFailure
    }
}

#if !SWIFT_PACKAGE
extension Bundle {
    static var module: Bundle = {
        return Bundle(for: QRScannerView.self)
    }()
}
#endif
