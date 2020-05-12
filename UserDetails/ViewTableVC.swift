//
//  ViewTableVC.swift
//  UserDetails
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit
import UserDetailsFramework

class ViewTableVC: UITableViewController {
    
    var mulUserDetailsFromQuery: [UserInfo] = [UserInfo]()
    var isFromQuery: Bool = false
    var fetchUserInfo: [UserInfo] = [UserInfo]()
    let request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let customCell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "customCell")
        
//        fetchUserInfo = UserDetailsCDManager.shared.fetchUserDetail()
//        print("stored user count viewtablevc", fetchUserInfo.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchUserInfo = request.fetchUserDetail()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromQuery {
            return mulUserDetailsFromQuery.count
        } else {
            return fetchUserInfo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        
        if isFromQuery {
            cell.nameOutlet.text = mulUserDetailsFromQuery[indexPath.row].fullName
            cell.genderOutlet.text = mulUserDetailsFromQuery[indexPath.row].gender
            cell.emailOutlet.text = mulUserDetailsFromQuery[indexPath.row].email
        } else {
            cell.nameOutlet.text = fetchUserInfo[indexPath.row].fullName
            cell.genderOutlet.text = fetchUserInfo[indexPath.row].gender
            cell.emailOutlet.text = fetchUserInfo[indexPath.row].email
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsVC {
            /// To pass respective model
            /// 1. From query for multiple users
            /// 2. From view stored data
            if isFromQuery {
                vc.userDetails = mulUserDetailsFromQuery[indexPath.row]
                /// To change store/delete button context
                vc.isFromQueryUD = true
            } else {
                vc.userDetails = fetchUserInfo[indexPath.row]
            }
            if let navController = navigationController {
                navController.pushViewController(vc, animated: true)
            }
        }
    }
}
