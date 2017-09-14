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
    
public func device_info(){
     Constant.device_id = UIDevice.current.identifierForVendor!.uuidString
     print(Constant.device_id)
        
   
}
    
    struct Constant {
      static var device_id: String = ""
    }
 
}
typealias InternalProperties = [String: Any]
var superProperties = InternalProperties()
