//
//  ViewController.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//

import UIKit
import Mapbox
import InteractiveSideMenu

class ViewController: UIViewController,  MGLMapViewDelegate, SideMenuItemContent  {
    
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var addToFavoritesBtn: UIButton!
    
    var currentUserLocation : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        //Setup User tracking
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(DataModel.sharedInstance.currentStyleURL != ""){
            print("will change style")
            let url = URL(string: DataModel.sharedInstance.currentStyleURL)
            mapView.styleURL = url
            mapView.reloadStyle(self)
        }
        
        if let location = DataModel.sharedInstance.currentLocation {
            mapView.setCenter(CLLocationCoordinate2D(latitude: (location.latitude), longitude: (location.longitude)), zoomLevel: 15, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        //if User allows tracking then open app to his/her location.
        //else open app to Cairo's location.
        if mapView.isUserLocationVisible {
            print("USER LOCATION VISIBLE ")
            mapView.setCenter(CLLocationCoordinate2D(latitude: (userLocation?.coordinate.latitude)!, longitude: (userLocation?.coordinate.longitude)!), zoomLevel: 15, animated: true)
            let userSimpleLocation = Location.init(locationName: "", longitude: (userLocation?.coordinate.longitude)!, latitude: (userLocation?.coordinate.latitude)! , saved: false)
            
            currentUserLocation = userSimpleLocation
            DataModel.sharedInstance.currentLocation = currentUserLocation!
            
        }else{
            if(!DataModel.sharedInstance.shouldResetMapCenter){
                //default Location: Cairo
                mapView.setCenter(CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), zoomLevel: 12, animated: true)
                DataModel.sharedInstance.shouldResetMapCenter = false
            }
        }
        
    }
    
    @IBAction func saveCurrentLocation(_ sender: Any) {
        if let _ = currentUserLocation {
            //Pop Up: Location added to saved locations.
            let alertController = UIAlertController(title: "Save this location", message: "Enter Location name.", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let locationNameTextField = alertController.textFields![0] as UITextField

                if locationNameTextField.text != "" {
                    self.addToFavoritesBtn.isHidden = true
                    
                    DataModel.sharedInstance.savedLocationsNames.append(String(describing: locationNameTextField.text!))
                    self.currentUserLocation!.saved = true
                    DataModel.sharedInstance.savedLocations.append(self.currentUserLocation!)
                    print("Current Location: " , self.currentUserLocation!.saved)
                    
                }else{
                    
                    let errorAlert = UIAlertController(title: "Alert", message: "Empty Location Name", preferredStyle: UIAlertControllerStyle.alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Location Name"
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            let errorAlert = UIAlertController(title: "Alert", message: "Location Services not working at the moment.", preferredStyle: UIAlertControllerStyle.alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        showSideMenu()
    }
    
    
    
}



