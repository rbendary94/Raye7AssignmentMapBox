//
//  SavedLocationsViewController.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import Mapbox

class SavedLocationsViewController: UIViewController , SideMenuItemContent , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var savedLocations : [Location] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedLocations = DataModel.sharedInstance.savedLocations
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showSideMenu(_ sender: Any) {
        showSideMenu()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedTableTableViewCell", for: indexPath) as! SavedLocationTableViewCell
        let location = savedLocations[indexPath.row]
        let text = (DataModel.sharedInstance.savedLocationsNames[indexPath.row])
        cell.locationNameLabel.text = text
        cell.latitudeLabel.text = "Latitude: " + String(describing: location.latitude)
        cell.longitudeLabel.text = "Longitude : " + String(describing:location.longitude)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HostViewController") as! HostViewController
        DataModel.sharedInstance.currentLocation = savedLocations[indexPath.row]

        DataModel.sharedInstance.shouldResetMapCenter = true
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
}


