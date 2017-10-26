//
//  UserPageViewController.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import PromiseKit

class UserPageViewController: UIViewController {
   
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var dataLoadActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var devicesLabel: UILabel!
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var storageUsedLabel: UILabel!
    @IBOutlet weak var storageProgressView: UIProgressView!
    @IBOutlet weak var deviceHashLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoView.isHidden = true

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userInfoView.isHidden = true
        dataLoadActivityIndicator.startAnimating()
        User.getUserMetaData()
            .then{ userMetaData -> Void in
                self.emailLabel.text = userMetaData.user?.email!
                self.planLabel.text = "Your plan: " + (userMetaData.user?.plan?.name)!
                let progress:Float = Float(userMetaData.planCapacity!.storageLimit! / userMetaData.user!.plan!.storageLimit!)
                self.storageProgressView.setProgress(progress, animated: false)
                self.moviesLabel.text = String(userMetaData.planCapacity!.moviesAmount!) + "/" + String(userMetaData.user!.plan!.moviesAmount!)
                self.devicesLabel.text = String(userMetaData.planCapacity!.devicesAmount!) + "/" + String(userMetaData.user!.plan!.devicesAmount!)
                self.storageUsedLabel.text = String(userMetaData.planCapacity!.storageLimit!) + " / " + String(userMetaData.user!.plan!.storageLimit!)
            }.always {
                self.dataLoadActivityIndicator.stopAnimating()
                self.userInfoView.isHidden = false
            }
            .catch {error in
                print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutEvent(_ sender: Any) {
        AutorizationManager.logout()
        
    }
    
    @IBAction func showGalleryBtn(_ sender: Any) {
        performSegue(withIdentifier: "ShowGallarySegue", sender: sender)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
