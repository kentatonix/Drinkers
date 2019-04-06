//
//  ViewController.swift
//  Drinkers
//
//  Created by kenta naito on 2019/04/02.
//  Copyright © 2019 kenta naito. All rights reserved.
//

import UIKit
// 以下を追加
import AWSMobileClient
import AWSS3
import AWSAppSync

class ViewController: UIViewController {
    var appSyncClient: AWSAppSyncClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AWSMobileClient.sharedInstance().initialize { (userState, error) in
            if let userState = userState {
                switch(userState){
                case .signedIn:
                    DispatchQueue.main.async {
                        print("Sign In")
                    }
                case .signedOut:
                    AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, { (userState, error) in
                        if(error == nil){       //Successful signin
                            DispatchQueue.main.async {
                                print("Sign In")
                            }
                        }
                    })
                default:
                    AWSMobileClient.sharedInstance().signOut()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
    }

    @IBAction func pushSignoutButton(_ sender: Any) {
        // サインアウト処理
        AWSMobileClient.sharedInstance().signOut()
        
        // サインイン画面を表示
        AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, { (userState, error) in
            if(error == nil){       //Successful signin
                DispatchQueue.main.async {
                    print("Sign In")
                }
            }
        })
    }
    
    @IBAction func nextpage(_ sender: Any) {
    }
    
}

