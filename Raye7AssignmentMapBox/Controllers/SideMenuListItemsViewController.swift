//
//  SideMenuListItemsViewController.swift
//  Raye7AssignmentMapBox
//
//  Created by Rana El Bendary on 12/13/17.
//  Copyright © 2017 Rana El Bendary. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class SideMenuListItemsViewController: MenuViewController , UITableViewDataSource, UITableViewDelegate{
    
    let kCellReuseIdentifier = "MenuCell"
    let menuItems = ["Current Location", "My Saved Locations", "Map Styles"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        menuContainerViewController.hideSideMenu()
    }
    
}


