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
import CoreTelephony
import CloudKit
import CoreBluetooth




public class WalinnsLib
{
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    var myBTManager: CBPeripheralManager?
    var start_time : Date?
    var end_time : Date?
    var called : String?
    var start_date : Int?
    var end_date : Int?
    var result : Int?
    var active_status : String?
   // NSSetUncaughtExceptionHandler(exceptionHandler)
   
    
    

    
    //device_data:;init("model","fv","os_name","os_version","connectivty","carrier","email","play_service",
    //"bluetooth","screen_dpi","screen_height","screen_width","age","gender","language")
 
    func exceptionHandler(exception : NSException) {
        print("11111111",exception)
        print("!!!!!!",exception.callStackSymbols)
    }

    public init (stop : String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let dater=dateFormatter.string(from: Date())
        
        
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let end_dateee = dateFormatter.date(from: dater)
        
        self.end_date=currentTimeInMiliseconds()
        miliSecFromDate(date: end_date!, flag: "stop")
        start_date=UserDefaults.standard.value(forKey: "start_date") as? Int
      //  print("Current_milliseconds_prev",  start_date ?? <#default value#>, end_date ?? <#default value#>)
        result=end_date!-start_date!
        
       // print("Current_milliseconds_different",  result ?? <#default value#>)
        
        let datee = NSDate(timeIntervalSince1970: Double(result!) / 1000)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh mm ss"
        print("*******1",formatter.string(from: datee as Date))
        
       
        
        let dateVar = Date(timeIntervalSinceNow: TimeInterval(result! / 1000))
        //var dateFormatter = DateFormatter();
        dateFormatter.timeZone=TimeZone.current
        dateFormatter.dateFormat = "hh:mm:ss";
        print("*******",dateFormatter.string(from: dateVar))
        
       // print("New_date", UserDefaults.standard.value(forKey: "dateee") ?? <#default value#>, end_dateee ?? <#default value#>)
        
     
        let val=end_dateee?.timeIntervalSince(UserDefaults.standard.value(forKey: "dateee") as! Date)
        
       // print("Date_diff", val ?? <#default value#>)
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: UserDefaults.standard.value(forKey: "dateee") as! Date)
        let date2 = calendar.startOfDay(for: end_dateee!)
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: date1, to: date2)
        
        
        let components2 = calendar.dateComponents([.hour, .minute, .second], from: date2)
        let date3 = calendar.date(bySettingHour: components2.hour!, minute: components2.minute!, second: components2.second!, of: date1)!
        
         print("Date_difffffffff", date3, components)
        
        apiSession(session: formatter.string(from: datee as Date), start_date: UserDefaults.standard.value(forKey: "start_date_format") as! String, end_date: UserDefaults.standard.value(forKey: "end_date_format") as! String)
        
        
        
        
    }
    
    public func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    func miliSecFromDate(date : Int, flag : String) {
        let milisecond = date;
        
        let dateVar = Date(timeIntervalSince1970: TimeInterval(milisecond / 1000))
        let dateFormatter = DateFormatter();
        dateFormatter.timeZone=TimeZone.current
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss";
        print(dateFormatter.string(from: dateVar));
        
       print("FLAG", flag)
        
        if(flag=="start"){
            print(">>>","inside_if")
            let dateVar = Date(timeIntervalSince1970: TimeInterval(milisecond / 1000))
            let dateFormatter = DateFormatter();
            dateFormatter.timeZone=TimeZone.current
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss";
            UserDefaults.standard.setValue(dateFormatter.string(from: dateVar), forKey: "start_date_format")
        }else if(flag=="stop"){
            print(">>>","inside_else")
            let dateVar = Date(timeIntervalSince1970: TimeInterval(milisecond / 1000))
            let dateFormatter = DateFormatter();
            dateFormatter.timeZone=TimeZone.current
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss";
            UserDefaults.standard.setValue(dateFormatter.string(from: dateVar), forKey: "end_date_format")
            
            }
    }
   
    public func yourFunctionName(finished: () -> Void) {
      
          let backgroundTask = UIBackgroundTaskInvalid
          print("App state", backgroundTask)
          DispatchQueue.global(qos: .background).async {
          print("This is run on the background queue")
            
            DispatchQueue.main.async {
                let state = UIApplication.shared.applicationState
                print("This is run on the main queue, after the previous code in outer block",state)
            }
        }

        print("Doing something!")
        
        
        finished()
        
    }
    
    public func appUninstall(fcm_token : String){
        
        let postString = ["device_id" : deviceID , "push_token" : fcm_token , "package_name" : "WalinsApp"]
        
        print("Request Data_uninstall_info",postString)
        var request = URLRequest(url: URL(string: "http://192.168.0.6:8080/api/v1/uninstallCount")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: postString, options: [])
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("errorggggg_unins=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response_unins = \(response)")
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString_unins= \(responseString)")
        }
        task.resume()



    }
    
    public func appuserData(){
        
        let url = "http://192.168.0.2:8080/api/v1/fetchAppUserDetail"
//        Alamofire.request(url, method: .get).validate(contentType: ["application/json"]).responseJSON{ response in
//            switch response.result{
//            case .success (let data):
//                // print("App user details :" , data)
//                let json = JSON(json: data)
//                print("App user details :" ,   json[0]["details"][0]["device_id"] )
//                break
//                
//            case .failure(let error):
//                print("Error_user_details: \(error)")
//                break
//            }
//        }
    
}
    
    func detriveData(res : String) {
        
        var data = res.data(using: .utf8)!
        
        let json = try? JSONSerialization.jsonObject(with: data)
        
    }
    func readJSONObject(object: [String: AnyObject]) {
        
        print("parse data",object)
//        guard let title = object["dataTitle"] as? String,
//            let version = object["swiftVersion"] as? Float,
//            let users = object["users"] as? [[String: AnyObject]] else { return }
//        _ = "Swift \(version) " + title
//        
//        for user in users {
//            guard let name = user["name"] as? String,
//                let age = user["age"] as? Int else { break }
//            switch age {
//            case 22:
//                _ = name + " is \(age) years old."
//            case 25:
//                _ = name + " is \(age) years old."
//            case 29:
//                _ = name + " is \(age) years old."
//            default:
//                break
//            }
//        }
    }

    public func eventTrack(event_name : String, event_type : String){
        
        print("DEVICE_ID_EVENT", event_name, event_type, deviceID )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from:Date())
        dateFormatter.dateFormat = "HH:mm:ss"
        let timeString = dateFormatter.string(from: Date())
        let date_time = dateString + " " + timeString
        
        
        
        var event_count = UserDefaults.standard.integer(forKey: event_name)
        
        // increment received number by one
        UserDefaults.standard.set(event_count+1, forKey:event_name)
        
        // save changes to disk
        UserDefaults.standard.synchronize()
        
        print("event_count", event_count)
        
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
       
        jsonObject.setValue(deviceID, forKey: "device_id")
        jsonObject.setValue("1", forKey: "total_event_count")
        
        let value : NSMutableDictionary = NSMutableDictionary()
        
        value.setValue(event_type, forKey: "event_type")
        value.setValue(event_name, forKey: "event_name")
        value.setValue(String(event_count), forKey: "event_count")
        value.setValue(date_time, forKey: "date_time")
        jsonObject.setValue(value, forKey: "events")
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
              let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string = \(jsonString)")
            print("JSONOBEJECT", jsonString)
     
            
            var request = URLRequest(url: URL(string: "http://192.168.0.3:8083/api/v1/event")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString_event = \(responseString)")
            }
            task.resume()
            
        } catch _ {
            print ("JSON Failure")
        }
        
        
        
        
    }
    public func stop(){
        called="stop"
       //  print("Start_timeeee_pref",  UserDefaults.standard.value(forKey: "start_date"))
        print("inside_stop", called)
        print("app stoped")
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/mm/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        var date=dateFormatter.string(from: Date())
        end_time = dateFormatter.date(from: date)!
        print("Start_time",  start_time, "endtime", end_time)
        
//        let duration =  end_time?.timeIntervalSince(start_time!)
//        print("Time Duration", duration)
        

      print("Current_milliseconds_stop",currentTimeInMiliseconds())
        

    }
    
    public func apiSession(session: String , start_date: String , end_date : String){
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        
        jsonObject.setValue(deviceID, forKey: "device_id")
        
        
        let value : NSMutableDictionary = NSMutableDictionary()
        
        value.setValue(session, forKey: "Session")
        value.setValue(start_date, forKey: "Start_time")
        value.setValue(end_date, forKey: "End_time")
        jsonObject.setValue(value, forKey: "data")
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string_session = \(jsonString)")
            print("JSONOBEJECT_session", jsonString)
            
            //gomu
            var request = URLRequest(url: URL(string: "http://192.168.0.3:8083/api/v1/session")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString_session = \(responseString)")
            }
            task.resume()
            
        } catch _ {
            print ("JSON Failure")
        }

    }
    
    struct DeviceInfo {
        var device_model: String
        var connectivty:String
        let networkString=""
        var deviceID : String
        let os_name=""
        let identifier=""
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
        let DEVICE_IS_SIMULATOR = true
        #else
        
        let DEVICE_IS_SIMULATOR = false
        #endif
        
        
        
        init(device_data: String) {
            
            //get deviceModel
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
            }else{
             device_model=""
            }
            print("DeviceModel-fata",  device_model)
            //Device id
            
              self.deviceID = UIDevice.current.identifierForVendor!.uuidString
           
            //Connectivity
            
            let networkInfo = CTTelephonyNetworkInfo()
           // let  networkString = networkInfo.currentRadioAccessTechnology!
              print("Connectivty",networkInfo)
            
            switch (networkString){
            case "CTRadioAccessTechnologyCDMA1x":
                print("2g")
                connectivty="2g"
            case  "CTRadioAccessTechnologyEdge" :
                print("2g")
                connectivty="2g"
                
            case "CTRadioAccessTechnologyGPRS":
                print("2g")
                connectivty="2g"
            case "CTRadioAccessTechnologyeHRPD":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyHSDPA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyHSUPA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyLTE":
                print("4g")
                connectivty="4g"
            case "CTRadioAccessTechnologyCDMAEVDORev0":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyCDMAEVDORevA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyCDMAEVDORevB":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyWCDMA":
                print("3g")
                connectivty="3g"
            default:
                print("2g")
                connectivty="2g"
        }
           print("Connectivty__",connectivty)
            
            var machineString = String()
            
            if DEVICE_IS_SIMULATOR == true
            {
                if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    machineString = dir
                }
            }
            else {
                var systemInfo = utsname()
                uname(&systemInfo)
                let machineMirror = Mirror(reflecting: systemInfo.machine)
                machineString = machineMirror.children.reduce("") { identifier, element in
                    guard let value = element.value as? Int8 , value != 0 else { return identifier }
                    return identifier + String(UnicodeScalar(UInt8(value)))
                }
            }
            
            
            let versionNumberString =
                Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                    as! String
            
            print("VERSION_DETAILS",identifier," VERSION: ",versionNumberString)
            
            print("Exampledata_libb",UIDevice.current.systemName,UIDevice.current.systemVersion)
             var addressString : String = ""
            var locManager = CLLocationManager()
            locManager.requestWhenInUseAuthorization()
            let ceo: CLGeocoder = CLGeocoder()
          //  let loc: CLLocation = CLLocation(latitude:(locManager.location?.coordinate.latitude)!, longitude: (locManager.location?.coordinate.longitude)!)
            
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    var pm: CLPlacemark!
//               // placeMark = placemarks?[0]
//                    
//                  //  if pm.count > 0 {
//                          pm = placemarks![0]
//                        print(pm.country)
//                        print(pm.locality)
//                        print(pm.subLocality)
//                        print(pm.thoroughfare)
//                        print(pm.postalCode)
//                        print(pm.subThoroughfare)
//                       
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//                        }
//                        
//                        
//                        print("location_lib",addressString)
//                   // }
//                    
//            })
            
            let pre = Locale.preferredLanguages[0]
            
            print("LANGUAGE",pre)
            
            let phoneCarrier = networkInfo.subscriberCellularProvider
          
            print("CARRIER",phoneCarrier?.carrierName)
            
            let nWidth = UIScreen.main.nativeBounds.width
            let nHeight = UIScreen.main.nativeBounds.height
            
            print("Screen_data", nWidth, nHeight)
            var carrier_name = phoneCarrier?.carrierName
            
            if(carrier_name != nil ){
                carrier_name=phoneCarrier?.carrierName
            }else{
                carrier_name="na"
            }
            
             let postString = ["device_id":deviceID, "device_model": device_model, "os_name": "ios","os_version":UIDevice.current.systemVersion,"connectivty":connectivty,"carrier":carrier_name,"email": "pinkygifty@gmail.com","play_service": "false","bluetooth":"false","screen_height":nHeight,"screen_width":nWidth ,"screen_dpi":"1720","age": "23","gender":"female","language":pre] as [String : Any]
            
             print("Request Data_device_info",postString)
             var request = URLRequest(url: URL(string: "http://192.168.0.3:8083/api/v1/fetchDeviceInfo")!)
             request.httpMethod = "POST"
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
               
             request.httpBody = try? JSONSerialization.data(withJSONObject: postString, options: [])
            
            
            
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, error == nil else {                                                 // check for fundamental networking error
                 print("errorggggg=\(error)")
                return
              }
            
              if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
               print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            
             }
            
             let responseString = String(data: data, encoding: .utf8)
              print("responseString = \(responseString)")
            }
            task.resume()
            
            
            let buildNumberString = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")as! String
            
            print("BUILDNUMBER",buildNumberString,addressString )

            
            
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString("Saravanampatti, Coimbatore, India, 641035") { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        // handle no location found
                        return
                }
                
                // Use your location
                print("fromaddress",location.coordinate.latitude,location.coordinate.longitude )
            }
            
            let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
            
            // increment received number by one
            UserDefaults.standard.set(currentCount+1, forKey:"launchCount")
            
            // save changes to disk
            UserDefaults.standard.synchronize()
            
            print("LAUNCH_count",currentCount)
        }
     

    }
    
   
}


    
    


