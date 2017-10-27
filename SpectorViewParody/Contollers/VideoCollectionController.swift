//
//  VideoCollectionController.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import Alamofire
class VideoCollectionController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    let moviesSource = MoviesManager.getInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesSource.getAllMovie().then{result -> Void in
            
            let r = result
            
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
        
        let book = moviesSource.movies[indexPath.row]
        0
        //cell.displayContent(image: store.images[indexPath.row], title: book.name)
        
        return cell
        
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

