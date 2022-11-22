//
//  DetailViewController.swift
//  Project 1
//
//  Created by Clément Villanueva on 15/07/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
        
        assert(selectedImage != nil)
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
