//
//  WalinnsLib.swift
//  WalinnsTracker
//
//  Created by WALINNS INNOVATION on 13/09/17.
//  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
//

import Foundation


public class WalinnsLib
{
    
private var isDebug: Bool!

//2.
public init() {
    self.isDebug = false
    print("Walinns library installed")
    
    }

//3.
public func setup(isDebug: Bool) {
    self.isDebug = isDebug
    print("Project is in Debug mode: \(isDebug)")
}

//4.
public func Print<T>(value: T) {
    if self.isDebug == true {
        print(value)
    } else {
        //Do any stuff for production mode
    }
}
    
}
