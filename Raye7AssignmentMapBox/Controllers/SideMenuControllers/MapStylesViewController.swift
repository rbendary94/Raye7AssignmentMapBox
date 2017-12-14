//
//  MapStylesViewController.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//


import UIKit
import InteractiveSideMenu

class MapStylesViewController: UIViewController , SideMenuItemContent, UITableViewDelegate, UITableViewDataSource{
    
    var styleNames : [String] = []
    var delegate = ViewController().self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNames = Array(DataModel.sharedInstance.mapStyleURLs.keys)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        showSideMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath)
        cell.textLabel?.text = styleNames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = DataModel.sharedInstance.mapStyleURLs[styleNames[indexPath.row]]!
        DataModel.sharedInstance.currentStyleURL = url
        DataModel.sharedInstance.currentStyleKey = styleNames[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HostViewController") as! HostViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}


