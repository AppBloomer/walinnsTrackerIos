/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Json4Swift_Base {
	public var tot_user_cunt : Int?
	public var act_usr_cunt : Int?
	public var daily_act_usr : Int?
	public var monthly_act_usr : Int?
	public var details : Array<Details>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Json4Swift_Base]
    {
        var models:[Json4Swift_Base] = []
        for item in array
        {
            models.append(Json4Swift_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		tot_user_cunt = dictionary["tot_user_cunt"] as? Int
		act_usr_cunt = dictionary["act_usr_cunt"] as? Int
		daily_act_usr = dictionary["daily_act_usr"] as? Int
		monthly_act_usr = dictionary["monthly_act_usr"] as? Int
		if (dictionary["details"] != nil) { details = Details.modelsFromDictionaryArray(array: dictionary["details"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.tot_user_cunt, forKey: "tot_user_cunt")
		dictionary.setValue(self.act_usr_cunt, forKey: "act_usr_cunt")
		dictionary.setValue(self.daily_act_usr, forKey: "daily_act_usr")
		dictionary.setValue(self.monthly_act_usr, forKey: "monthly_act_usr")

		return dictionary
	}

}
