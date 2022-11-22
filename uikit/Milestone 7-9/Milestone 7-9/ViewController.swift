//
//  ViewController.swift
//  Milestone 7-9
//
//  Created by Clément Villanueva on 20/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [String]()
    var usedLetters = [String]()
    var randomWord = ""
    
    var triesLeft = 10 {
        didSet {
            triesLeftLabel.text = "TRIES LEFT: \(triesLeft)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    @IBOutlet var randomWordLabel: UILabel!
    
    @IBOutlet var triesLeftLabel: UILabel!
    
    @IBOutlet var answerTextField: UITextField!
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    
    var currentAnswer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.setTitle("Check", for: .normal)
        checkButton.addTarget(self, action: #selector(submitAnswer), for: .touchUpInside)
        
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearAnswer), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
                
        startGame()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func startGame() {
        loadWords()
        
        if let random = words.randomElement()?.uppercased() {
            randomWord = random
        } else {
            showError(type: .NoWordFound)
        }
        
        usedLetters.removeAll()
        randomWordLabel.text = obfuscate(randomWord)
        
        triesLeft = 10
        triesLeftLabel.text = "TRIES LEFT: \(triesLeft)"
        
        scoreLabel.text = "SCORE: \(score)"
        
        print(randomWord)
    }
    
    @objc func loadWords() {
        if let wordsFileURL = Bundle.main.url(forResource: "words-fr", withExtension: "txt") {
            if let content = try? String(contentsOf: wordsFileURL) {
                let components = content.components(separatedBy: "\n")
                
                for (_, word) in components.enumerated() {
                    words.append(word)
                }
            }
        }
    }
    
    @objc func submitAnswer() {
        if answerTextField.text == "" {
            showError(type: .NoAnswerProvided)
            return
        }
        
        if triesLeft == 0 {
            endGame(.loose)
        }
        
        guard let answer = answerTextField.text?.uppercased() else {
            showError(type: .NoWordFound)
            return
        }
        
        currentAnswer = answer
        answerTextField.text = ""
        
        for letter in currentAnswer {
            let strLetter = String(letter)
            if randomWord.contains(strLetter) {
                usedLetters.append(strLetter)
            } else {
                if triesLeft == 0 {
                    endGame(.loose)
                } else {
                    triesLeft -= 1
                }
            }
        }
        
        randomWordLabel.text = obfuscate(randomWord)
        
        if !randomWordLabel.text!.contains("-") {
            score += 1
            endGame(.win)
        }
    }
    
    @objc func clearAnswer() {
        answerTextField.text = ""
    }
    
    func obfuscate(_ word: String) -> String {
        var obfuscatedWord = ""
        
        for letter in word {
            let strLetter = String(letter)
            if usedLetters.contains(strLetter) {
                obfuscatedWord.append(strLetter)
            } else {
                obfuscatedWord.append("-")
            }
        }
        
        return obfuscatedWord
    }
    
    func endGame(_ ending: Ending) {
        var title = ""
        
        switch ending {
            case .win:
                title = "You won!"
            case .loose:
                title = "You lost!"
        }
        
        let ac = UIAlertController(title: "\(title)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_: UIAlertAction!) in self.startGame()}))
        present(ac, animated: true)
    }
    
    func showError(type: Error) {
        let ac: UIAlertController
        let title: String
        let message: String
        
        switch type {
            case .WordListNotFound:
                title = "Word list not found"
                message = "Can't find the word list."
            case .NoWordFound:
                title = "Word not found"
                message = "No word was found in list."
            case .CurrentAnswerEmpty:
                title = "Empty answer"
                message = "You can't provide empty answers."
            case .NoAnswerProvided:
                title = "No answer provided"
                message = "You must provide a word or letters."
        }
        
        ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

