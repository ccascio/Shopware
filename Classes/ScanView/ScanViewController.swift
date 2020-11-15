//
//  ScanViewController.swift
//  app
//
//  Created by Calogero Cascio on 13/09/2020.
//  Copyright © 2020 KZ. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift

class ScanViewController: RSCodeReaderViewController {

    var dispatched: Bool = false

    @IBOutlet var toggle: UIButton!

    @IBAction func switchCamera(_ sender: AnyObject?) {
        let position = self.switchCamera()
        if position == AVCaptureDevice.Position.back {
            print("back camera.")
        } else {
            print("front camera.")
        }
    }

    @IBAction func close(_ sender: AnyObject?) {
        print("close called.")
        DispatchQueue.main.async {
            self.dismiss(animated: false)
        }
    }

    @IBAction func toggle(_ sender: AnyObject?) {
        let isTorchOn = self.toggleTorch()
        print(isTorchOn)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: NOTE: Uncomment the following line to enable crazy mode
        // self.isCrazyMode = true

        self.focusMarkLayer.strokeColor = UIColor.red.cgColor

        self.cornersLayer.strokeColor = UIColor.yellow.cgColor

        self.tapHandler = { point in
            print(point)
        }

        // MARK: NOTE: If you want to detect specific barcode types, you should update the types
        var types = self.output.availableMetadataObjectTypes
        // MARK: NOTE: Uncomment the following line remove QRCode scanning capability
        types = types.filter({ $0 != AVMetadataObject.ObjectType.qr })
        self.output.metadataObjectTypes = types

        // MARK: NOTE: If you layout views in storyboard, you should these 3 lines
        for subview in self.view.subviews {
            self.view.bringSubviewToFront(subview)
        }

        self.toggle.isEnabled = self.hasTorch()

        self.barcodesHandler = { barcodes in
            if !self.dispatched { // triggers for only once
                self.dispatched = true
                for barcode in barcodes {
                    guard let barcodeString = barcode.stringValue else { continue }

                    let barcode = CommonFunctions().readBarcode(barcode: barcodeString, type: barcode.type.rawValue)
                    
                    StoreStruct.scanned.append(barcode)
                    StoreStruct.product.append(barcode)
                    DispatchQueue.main.async {
                        self.dismiss(animated: false)
                    }
                    if kDebugLog {
                        print("Barcode found: type=" + barcode.barcode + " value=" + barcodeString)
                    }

                    // MARK: NOTE: break here to only handle the first barcode object
                    break
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.dispatched = false // reset the flag so user can do another scan
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        if segue.identifier == "nextView" && !self.barcode.isEmpty {
//            if let destinationVC = segue.destination as? BarcodeDisplayViewController {
//                destinationVC.contents = self.barcode
//            }
//        }
    }
}
