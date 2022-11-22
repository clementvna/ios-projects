//
//  ViewController.swift
//  Project 2
//
//  Created by Clément Villanueva on 15/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!

	var countries = [String]()
    var correctAnswer = 0
	var score = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1

		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor

		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		askQuestion()
	}

	func askQuestion(action: UIAlertAction! = nil) {
		countries.shuffle()

		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
		title = countries[correctAnswer].uppercased()
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
        
        sender.layer.borderColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.imageView?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: { _ in
            sender.imageView?.transform = .identity
            sender.layer.borderColor = UIColor.lightGray.cgColor
        })

		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else {
			title = "Wrong"
			score -= 1
		}

		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}

}
