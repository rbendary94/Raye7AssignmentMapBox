//
//  DataModel.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//

import Foundation
import Mapbox

class DataModel{
    
    static let sharedInstance = DataModel()
    private init(){}
    var currentLocation : Location?
    var shouldResetMapCenter = false
    var savedLocations : [Location] = []
    var savedLocationsNames : [String] = []
    var currentStyleURL = ""
    var currentStyleKey = ""
    
    let mapStyleURLs : [String : String] = ["Streets":"mapbox://styles/mapbox/streets-v10",
                                            "Dark":"mapbox://styles/mapbox/dark-v9",
                                            "Light":"mapbox://styles/mapbox/light-v9",
                                            "Outdoors":"mapbox://styles/mapbox/outdoors-v10",
                                            "Satellite Streets":"mapbox://styles/mapbox/satellite-streets-v10",
                                            "Satellite":"mapbox://styles/mapbox/satellite-v9"]
    
    let mapShouldReverseColor : [String : Bool] = ["Streets": false,
                                                   "Dark":true,
                                                   "Light":false,
                                                   "Outdoors":false,
                                                   "Satellite Streets":true,
                                                   "Satellite":true]
    
    
    //save data
    func saveData(key : String) {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode([savedLocations,savedLocationsNames], forKey: key)
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    //read data
    func loadData(key: String) {
        let path = self.dataFilePath()
        let defaultManager = FileManager()
        if defaultManager.fileExists(atPath: path) {
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            let array = unarchiver.decodeObject(forKey: key) as! Array<Any>
            savedLocations = array[0] as! [Location]
            savedLocationsNames = array[1] as! [String]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/raye7EvaluationTask.plist")
    }
}

