//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by 伴地慶介 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {

    var currentQuestionNum: Int = 0
    var questions: [[String: Any]] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "questions") != nil) {
            questions = userDefaults.object(forKey: "questions") as! [[String : Any]]
        }

        showQuestion()

        enableYesNoButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "questions") != nil) {
            questions = userDefaults.object(forKey: "questions") as! [[String : Any]]
        }

        showQuestion()

        enableYesNoButton()

    }

    func showQuestion() {
        if questions.count == 0 {
            questionLabel.text = "問題がありません。問題を作りましょう。"
        } else {
            let question = questions[currentQuestionNum]
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }
    }
    
    func enableYesNoButton() {
        if questions.count == 0 {
            noButton.isEnabled = false
            noButton.alpha = 0.3
            yesButton.isEnabled = false
            yesButton.alpha = 0.3
        } else {
            noButton.isEnabled = true
            noButton.alpha = 1.0
            yesButton.isEnabled = true
            yesButton.alpha = 1.0
        }
    }
    
    func checkAnswer(yourAnswer: Bool) {
        let question = questions[currentQuestionNum]
        if let ans = question["answer"] as? Bool {
            if yourAnswer == ans {
                currentQuestionNum += 1
                showAlert(message: "Correct!!!")
            } else {
                showAlert(message: "InCorrect...")
            }
        } else {
            print("there is no answer...")
            return
        }
        
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        showQuestion()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
        
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
}

