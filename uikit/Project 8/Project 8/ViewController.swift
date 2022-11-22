//
//  ViewController.swift
//  Project 8
//
//  Created by Clément Villanueva on 12/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var clueslabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var rightAnswers = 0
        
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "SCORE: 0"
        view.addSubview(scoreLabel)
        
        clueslabel = UILabel()
        clueslabel.translatesAutoresizingMaskIntoConstraints = false
        clueslabel.font = UIFont.systemFont(ofSize: 24)
        clueslabel.text = "CLUES"
        clueslabel.numberOfLines = 0
        clueslabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(clueslabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo:view.layoutMarginsGuide.trailingAnchor),
            clueslabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            clueslabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100.0),
            clueslabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100.0),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100.0),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100.0),
            answersLabel.heightAnchor.constraint(equalTo: clueslabel.heightAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: clueslabel.bottomAnchor, constant: 20.0),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100.0),
            submit.heightAnchor.constraint(equalToConstant: 44.0),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100.0),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44.0),
            buttonsView.widthAnchor.constraint(equalToConstant: 750.0),
            buttonsView.heightAnchor.constraint(equalToConstant: 350.0),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20.0),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20.0),
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
        
        loadLevel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        DispatchQueue.global().async { [self] in
            if let levelFileURL = Bundle.main.url(forResource: "Levels/level\(level)", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()

                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]

                        clueString += "\(index + 1). \(clue)\n"

                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        solutions.append(solutionWord)

                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
            
            DispatchQueue.main.async { [self] in
                clueslabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                letterBits.shuffle()
                
                if letterBits.count == letterButtons.count {
                    for i in 0 ..< letterButtons.count {
                        letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
            }
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
            currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
            activatedButtons.append(sender)
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                sender.imageView?.alpha = 0
            }, completion: { _ in
                sender.isHidden = true
            })
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }

        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()

            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")

            currentAnswer.text = ""
            rightAnswers += 1
            score += 1

            if rightAnswers % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Wrong", message: "Your answer is incorrect. You lost a point.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
            
            clearTapped(sender)
            
            score -= 1
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""

        for button in activatedButtons {
            button.isHidden = false
        }

        activatedButtons.removeAll()
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)

        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
}

