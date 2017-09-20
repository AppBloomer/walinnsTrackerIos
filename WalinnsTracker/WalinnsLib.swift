//
//  WalinnsLib.swift
//  WalinnsTracker
//
//  Created by WALINNS INNOVATION on 13/09/17.
//  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation



public class WalinnsLib
{
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    //device_data:;init("model","fv","os_name","os_version","connectivty","carrier","email","play_service",
    //"bluetooth","screen_dpi","screen_height","screen_width","age","gender","language")
    
    init(){
        
        print("DEVICE_DATA",DeviceInfo.init(device_data: "device_model"))
        
    }
    
    
    
    
    struct DeviceInfo {
        var device_model: String
        init(device_data: String) {
            var systemInfo = utsname()
            uname(&systemInfo)
            let size = MemoryLayout<CChar>.size
            let modelCode = withUnsafePointer(to: &systemInfo.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: size) {
                    String(cString: UnsafePointer<CChar>($0))
                }
            }
            if let model = String(validatingUTF8: modelCode) {
                
                device_model=model
            }
            device_model=""
        }
        
    }
    
 }
 
