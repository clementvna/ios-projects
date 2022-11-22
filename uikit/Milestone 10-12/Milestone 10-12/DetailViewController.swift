//
//  DetailViewController.swift
//  Milestone 10-12
//
//  Created by Clément Villanueva on 08/08/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var pictureView: UIImageView!
    var pictureName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pictureName
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let pictureToLoad = pictureName {
            pictureView.image = UIImage(named: pictureToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
