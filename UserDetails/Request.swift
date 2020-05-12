//
//  Request.swift
//  UserDetails
//
//  Created by Dadha Kumar on 12/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
import UserDetailsFramework

class Request {
    func queryGenderUserId(gender: String? = "", userId: String? = "", completionHandler: @escaping(UserInfo?, Error?) -> Void) {
        FetchUserDetails.sharedInstance.executeUrlRequestMethod(gender: gender, userId: userId) { (userInfo, error) in
            completionHandler(userInfo, error)
        }
    }

    func queryMulUsers(mulUsers: String?, completionHandler: @escaping([UserInfo]?, Error?) -> Void) {
        FetchUserDetails.sharedInstance.executeUrlRequestMulUsers(mulUsers: mulUsers) { (userInfo, error) in
            completionHandler(userInfo, error)
        }
    }
    
    func fetchUserDetail() -> [UserInfo] { UserDetailsCDManager.shared.fetchUserDetail()
    }
}
