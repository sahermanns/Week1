//
//  LoginService.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/4/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  class func loginForTwitter (completionHandler : (String?, ACAccount?) -> (Void)) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (successful, error) -> Void in
      if let error = error {
        completionHandler("there was an error while accessing your account", nil)
      } else {
        if successful {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil,account)
          } else {
            completionHandler("Twitter service is required for this app", nil)
          }
        }
      }
    }
  }
}



