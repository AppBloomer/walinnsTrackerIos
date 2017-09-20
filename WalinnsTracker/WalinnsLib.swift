//
//  WalinnsLib.swift
//  WalinnsTracker
//
//  Created by WALINNS INNOVATION on 13/09/17.
//  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
//

import Foundation
import UIKit


public class WalinnsLib
{

public init() {
       print("Walinns library installed")
    }
    
    public static func device_info(name : String){
     print(name)
     Constant.device_id = UIDevice.current.identifierForVendor!.uuidString
     print(Constant.device_id)
     Constant.device_model=deviceModel()
     print(Constant.device_model)
        
   
}
    
public static func deviceModel()-> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let size = MemoryLayout<CChar>.size
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: size) {
                String(cString: UnsafePointer<CChar>($0))
            }
        }
        if let model = String(validatingUTF8: modelCode) {
            return model
        }
        return ""
    }

    
struct Constant {
      static var device_id: String = ""
      static var device_model=""
    }
 
}
 
