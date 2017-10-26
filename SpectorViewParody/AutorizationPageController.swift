//
//  ViewController.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class AutorizationPageController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if User.getLocalUserInfo(){
            self.startNavigationView()
        }
    }
    
    @IBAction func enterEvent(_ sender: Any) {
        
        loginActivityIndicator.startAnimating()
        AutorizationManager.login(email: emailField.text!, password: passwordField.text!).then{user -> Void in
            self.startNavigationView()
            
            
            }.always {
                self.loginActivityIndicator.stopAnimating()
            }.catch {error in
                self.infoLabel.text = error.localizedDescription
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func startNavigationView (){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "navigationController") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}

