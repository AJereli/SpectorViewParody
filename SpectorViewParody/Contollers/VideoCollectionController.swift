//
//  VideoCollectionController.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

class VideoCollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    let moviesSource = MoviesManager.getInstance
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)

        collectionView.addSubview(refreshControl)

        
    }
    @objc func pullToRefresh(sender:AnyObject) {
        moviesSource.getAllMovie().then{result -> Void in
            self.moviesSource.movies = result
            }.then {_ -> Void in
                self.collectionView.reloadData()
            }.always {
                self.refreshControl.endRefreshing()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    private func loadData(){
        loadActivityIndicator.startAnimating()
        moviesSource.getAllMovie().then{result -> Void in
            self.moviesSource.movies = result
            }.then {_ -> Void in
                self.collectionView.reloadData()
                
            }.always {
                self.loadActivityIndicator.stopAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return moviesSource.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        
        if moviesSource.movies[indexPath.row].video != nil {
            cell.displayContent(imageUrl: (moviesSource.movies[indexPath.row].thumbnail?.url)!, title: (moviesSource.movies[indexPath.row].video?.fileName)!)
        }else{
            cell.displayContent(imageUrl: (moviesSource.movies[indexPath.row].photo?.url)!, title: (moviesSource.movies[indexPath.row].photo?.fileName)!)
        }
        return cell
        
    }
    private func showImageFullScrean(_ image:UIImage){
        let newImageView = UIImageView(image:image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromTop,
                                  animations: {self.view.addSubview(newImageView)}, completion: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromBottom,
                          animations: {sender.view?.removeFromSuperview()}, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = moviesSource.movies[indexPath.row].video?.url{
            let playerViewController = AVPlayerViewController()
            playerViewController.player = AVPlayer(url: URL(string: url)!)
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            if cell.imageView!.image != nil{
                showImageFullScrean(cell.imageView!.image!)
            }
        }
        
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


