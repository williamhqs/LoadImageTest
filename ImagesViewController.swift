//
//  ImagesViewController.swift
//  LoadImageTest
//
//  Created by William Hu on 6/13/17.
//  Copyright © 2017 William Hu. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageURLs = ["http://f.hiphotos.baidu.com/image/h%3D200/sign=c2ab414c753e6709a10042ff0bc79fb8/aa64034f78f0f736caeef16a0055b319ebc4134c.jpg","http://kaleidosblog.com/tutorial/img/photo-1441906363162-903afd0d3d52.jpg","http://kaleidosblog.com/tutorial/img/photo-1442120108414-42e7ea50d0b5.jpg","http://www.apple.com/euro/ios/ios8/a/generic/images/og.png","http://kaleidosblog.com/tutorial/img/photo-1443527216320-7e744084f5a7.jpg","http://kaleidosblog.com/tutorial/img/photo-1445127040028-b1bdb9acd16e.jpg","http://kaleidosblog.com/tutorial/img/photo-1446034295857-c39f8844fad4.jpg","http://kaleidosblog.com/tutorial/img/photo-1446071103084-c257b5f70672.jpg","http://kaleidosblog.com/tutorial/img/photo-1446426156356-92b664d86b77.jpg","http://kaleidosblog.com/tutorial/img/photo-1447522200268-a0378dac3fba.jpg","http://kaleidosblog.com/tutorial/img/photo-1447678523326-1360892abab8.jpg","http://kaleidosblog.com/tutorial/img/photo-1447752875215-b2761acb3c5d.jpg","http://via.placeholder.com/350x150","http://images.freeimages.com/images/previews/520/mexican-flag-2-closeup-1444837.jpg","http://images.freeimages.com/images/previews/f43/bumblebee-3-1551632.jpg","http://f.hiphotos.baidu.com/image/h%3D200/sign=c2ab414c753e6709a10042ff0bc79fb8/aa64034f78f0f736caeef16a0055b319ebc4134c.jpg","http://kaleidosblog.com/tutorial/img/photo-1441906363162-903afd0d3d52.jpg","http://kaleidosblog.com/tutorial/img/photo-1442120108414-42e7ea50d0b5.jpg","http://www.apple.com/euro/ios/ios8/a/generic/images/og.png","http://kaleidosblog.com/tutorial/img/photo-1443527216320-7e744084f5a7.jpg","http://kaleidosblog.com/tutorial/img/photo-1445127040028-b1bdb9acd16e.jpg","http://kaleidosblog.com/tutorial/img/photo-1446034295857-c39f8844fad4.jpg","http://kaleidosblog.com/tutorial/img/photo-1446071103084-c257b5f70672.jpg","http://kaleidosblog.com/tutorial/img/photo-1446426156356-92b664d86b77.jpg","http://kaleidosblog.com/tutorial/img/photo-1447522200268-a0378dac3fba.jpg","http://kaleidosblog.com/tutorial/img/photo-1447678523326-1360892abab8.jpg","http://kaleidosblog.com/tutorial/img/photo-1447752875215-b2761acb3c5d.jpg","http://via.placeholder.com/350x150","http://images.freeimages.com/images/previews/520/mexican-flag-2-closeup-1444837.jpg","http://images.freeimages.com/images/previews/f43/bumblebee-3-1551632.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loadImage(urlString: String, imageView: UIImageView) {
//        print(urlString)
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        request.timeoutInterval = 10
        request.cachePolicy = .returnCacheDataElseLoad
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, e: Error?) in
            if e == nil {
                print("I am the in")
                print(urlString)
                if let image = UIImage(data: data!) {
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                    
                }
            } else {
//                print(e?.localizedDescription)
            }
            
            
            
        }
        task.resume()
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath) as! CollectionViewCell
        loadImage(urlString: imageURLs[indexPath.row], imageView: cell.imageView)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
}
