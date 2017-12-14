//
//  DataTypes.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//

import Foundation

class Location : NSObject, NSCoding {
    
    var locationName : String
    var longitude : Double
    var latitude : Double
    var saved : Bool
    
    init(locationName : String, longitude:Double , latitude : Double , saved: Bool) {
        self.locationName = locationName
        self.longitude = longitude
        self.latitude = latitude
        self.saved = saved
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(locationName, forKey:"locationName")
        aCoder.encode(longitude, forKey:"longitude")
        aCoder.encode(latitude, forKey:"latitude")
        aCoder.encode(saved, forKey:"saved")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.locationName = aDecoder.decodeObject(forKey: "locationName") as? String ?? ""
        self.longitude = aDecoder.decodeDouble(forKey: "longitude")
        self.latitude = aDecoder.decodeDouble(forKey: "latitude")
        self.saved = aDecoder.decodeBool(forKey: "saved")
        
    }
    
    
    
}


