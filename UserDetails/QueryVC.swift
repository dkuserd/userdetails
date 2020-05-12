//
//  QueryVC.swift
//  UserDetails
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit
import UserDetailsFramework

class QueryVC: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var genderTFOutlet: UITextField!
    @IBOutlet weak var userIdTFOutlet: UITextField!
    @IBOutlet weak var mulUsersTFOutlet: UITextField!
    
    var hamMenu = HamMenuTransition()
    var viewTableVC = ViewTableVC()
    var userDetailsFromQuery: UserInfo = UserInfo()
    var userDetailsMulUsers: [UserInfo] = [UserInfo]()
    let request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        genderTFOutlet.text = ""
        userIdTFOutlet.text = ""
        mulUsersTFOutlet.text = ""
    }
    
    @IBAction func menuTapAction(_ sender: UIBarButtonItem) {
        guard let menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuTableVC") as? MenuTableVC else { return }
        
        menuVC.isMenuTapped = { sideMenuItem in
            self.newVCName(sideMenuItem)
            self.loadNewVC(sideMenuItem: sideMenuItem)
        }
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        present(menuVC, animated: true) {
        }
    }
    
    @IBAction func queryButtonAction(_ sender: UIButton) {
        
        if let genderValue = genderTFOutlet.text, !genderValue.isEmpty,
            let userIdValue = userIdTFOutlet.text, userIdValue.isEmpty,
            let mulUsersValue = mulUsersTFOutlet.text, mulUsersValue.isEmpty {
            queryGenderUserId(gender: genderValue)
            
        } else if let userIdValue = userIdTFOutlet.text, !userIdValue.isEmpty, let mulUsersValue = mulUsersTFOutlet.text, mulUsersValue.isEmpty {
            queryGenderUserId(userId: userIdValue)
            
        } else if let mulUsersValue = mulUsersTFOutlet.text, !mulUsersValue.isEmpty {
            queryMulUsers(mulUsers: mulUsersValue)
        }
    }
    
    func setTextFieldDelegate() {
        genderTFOutlet.delegate = self
        userIdTFOutlet.delegate = self
        mulUsersTFOutlet.delegate = self
    }
    func newVCName(_ sideMenuItem: SideMenuItems) {
        switch sideMenuItem {
        case .queryUser:
            self.title = "Query User"
        case .viewStoredData:
            self.title = "View Stored Data"
        case .exit:
            self.title = "Query User"
        }
    }
    
    func loadNewVC(sideMenuItem: SideMenuItems) {
        removeChildVC()
        switch sideMenuItem {
            
        case .viewStoredData:
            addChild(viewTableVC)
            self.view.addSubview(viewTableVC.view)
            viewTableVC.didMove(toParent: self)
        default:
            break
        }
    }
    
    func removeChildVC() {
        if self.children.count > 0 {
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        hamMenu.showVC = true
        return hamMenu
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        hamMenu.showVC = false
        return hamMenu
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension QueryVC {
    
    func queryGenderUserId(gender: String? = "", userId: String? = "") {
        request.queryGenderUserId(gender: gender, userId: userId) { (userInfo, error) in
            if let userInfoUnwrapped = userInfo {
                self.userDetailsFromQuery = userInfoUnwrapped
            }
            DispatchQueue.main.async {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsVC {
                    vc.userDetails = self.userDetailsFromQuery
                    vc.isFromQueryUD = true
                    if let navController = self.navigationController {
                        navController.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func queryMulUsers(mulUsers: String?) {
        request.queryMulUsers(mulUsers: mulUsers) { (userInfo, error) in
            if let userInfoUnwrapped = userInfo {
                self.userDetailsMulUsers = userInfoUnwrapped
            }
            DispatchQueue.main.async {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewTableVC") as? ViewTableVC {
                    vc.mulUserDetailsFromQuery = self.userDetailsMulUsers
                    vc.isFromQuery = true
                    if let navController = self.navigationController {
                        navController.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}
