//
//  ProjectsViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/26/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setBackgroudAsGradient()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButtonAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.TokenKey.rawValue)
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.isLoggedIn.rawValue)
        NetworkManager.shared().deregisterAccessToken()
        let storybaord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybaord.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
