//
//  ViewController.swift
//  MTSCRADemoSwift
//
//  Created by Adam Chin on 1/1/17.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MTSCRAEventDelegate {

    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var last4Value: UILabel!
    @IBOutlet weak var expr: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    var lib = MTSCRA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lib = MTSCRA()
        lib.delegate = self;
        
        lib.setDeviceType(UInt32(MAGTEKAUDIOREADER))
        
        lib.listen(forEvents: UInt32(TRANS_EVENT_OK)|UInt32(TRANS_EVENT_START)|UInt32(TRANS_EVENT_ERROR))
        
         self.textView.text = "Magtek SDK Version \(lib.getSDKVersion())"
        
        self.nameValue.text = ""
        self.last4Value.text = ""
        self.expr.text = ""
    }
    
    @IBAction func connect(_ sender: Any) {
        lib.openDevice()
    }
    override func viewDidAppear(_ animated: Bool) {
        //
        if lib.isDeviceConnected() {
            self.textView.text = "Connected"
        } else if lib.isDeviceConnected() {
            self.textView.text = "Disconnected"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onDataReceived(_ cardDataObj: MTCardData!, instance: Any!) {
        
        DispatchQueue.main.async {
            let  cardResponse = String(format: "Track.Status: %@\n\nTrack1.Status: %@\n\nTrack2.Status: %@\n\nTrack3.Status: %@\n\nEncryption.Status: %@\n\nTrack.Masked: %@\n\nTrack1.Masked: %@\n\nTrack2.Masked: %@\n\nTrack3.Masked: %@\n\nTrack1.Encrypted: %@\n\nTrack2.Encrypted: %@\n\nTrack3.Encrypted: %@\n\nCard.PAN: %@\n\nCard.IIN: %@\n\nCard.Name: %@\n\nCard.Last4: %@\n\nCard.ExpDate: %@\n\nCard.ExpDateMonth: %@\n\nCard.ExpDateYear: %@\n\nCard.SvcCode: %@\n\nCard.PANLength: %ld\n\nKSN: %@\n\nDevice.SerialNumber: %@\n\nFirmware Revision Number: %@\n\nMagnePrint: %@\n\nMagnePrint.Length: %i\n\nMagnePrintStatus: %@\n\nSessionID: %@\n\nDevice Model Name: %@\n\n",         cardDataObj.trackDecodeStatus,
                                       cardDataObj.track1DecodeStatus,
                                       cardDataObj.track2DecodeStatus,
                                       cardDataObj.track3DecodeStatus,
                                       cardDataObj.encryptionStatus,
                                       cardDataObj.maskedTracks,
                                       cardDataObj.maskedTrack1,
                                       cardDataObj.maskedTrack2,
                                       cardDataObj.maskedTrack3,
                                       cardDataObj.encryptedTrack1,
                                       cardDataObj.encryptedTrack2,
                                       cardDataObj.encryptedTrack3,
                                       cardDataObj.cardPAN,
                                       cardDataObj.cardIIN,
                                       cardDataObj.cardName,
                                       cardDataObj.cardLast4,
                                       cardDataObj.cardExpDate,
                                       cardDataObj.cardExpDateMonth,
                                       cardDataObj.cardExpDateYear,
                                       cardDataObj.cardServiceCode,
                                       cardDataObj.cardPANLength,
                                       cardDataObj.deviceKSN,
                                       cardDataObj.deviceSerialNumber,
                                       cardDataObj.deviceFirmware,
                                       cardDataObj.encryptedMagneprint,
                                       cardDataObj.magnePrintLength,
                                       cardDataObj.magneprintStatus,
                                       cardDataObj.encrypedSessionID,
                                       cardDataObj.deviceName)
            
            
             self.textView.text = "Received Card Data:\n \(cardResponse)"
            
            self.nameValue.text="Card Name: \(cardDataObj.cardName!)"
            
            self.last4Value.text="Last 4: \(cardDataObj.cardLast4!)"
            self.expr.text = "Exp: \(cardDataObj.cardExpDate!)"
            
            
        }
        
    }
    
    @objc func onDeviceError(_ error: Error!) {
        DispatchQueue.main.async {self.textView.text = "Device Error :\n \(error.localizedDescription)"}
    }
    
    @objc func onDeviceConnectionDidChange(_ deviceType: UInt, connected: Bool, instance: Any!) {
        
        if (lib.isDeviceOpened()){
            if (connected){
               DispatchQueue.main.async {self.textView.text = "Connected to :\n \(deviceType)"}
            }
        }
        
        
    }
}
