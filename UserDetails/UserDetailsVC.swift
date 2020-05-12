//
//  UserDetailsVC.swift
//  UserDetails
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit
import UserDetailsFramework

enum ButtonName: String {
    case store = "Store"
    case delete = "Delete"
}

class UserDetailsVC: UIViewController {
    
    @IBOutlet weak var userIdOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var genderOutlet: UILabel!
    @IBOutlet weak var ageOutlet: UILabel!
    @IBOutlet weak var dobOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var storeDeleteBOutlet: UIButton!
    
    var userDetails: UserInfo = UserInfo()
    var isFromQueryUD: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUserDetails()
    }
    
    @IBAction func storeAction(_ sender: UIButton) {
        /// To decide store/delete
        if isFromQueryUD {
            UserDetailsCDManager.shared.storeUserDetail(storeUserInfo: userDetails)
        } else {
            UserDetailsCDManager.shared.deleteUserDetail(userInfo: userDetails)
        }
    }
    
    func setupUserDetails() {
        userIdOutlet.text = userDetails.userId
        nameOutlet.text = userDetails.fullName
        genderOutlet.text = userDetails.gender
        ageOutlet.text = userDetails.age
        dobOutlet.text = userDetails.dob
        emailOutlet.text = userDetails.email
        if isFromQueryUD {
            storeDeleteBOutlet.setTitle(ButtonName.store.rawValue, for: .normal)
        } else {
            storeDeleteBOutlet.setTitle(ButtonName.delete.rawValue, for: .normal)
        }
    }
}
