//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by 伴地慶介 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showQuestion()
    }

    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    let questions: [[String: Any]] = [
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
                        "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
                        "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
                        "answer": true
        ],
    ]
    
    func showQuestion() {
        let question = questions[currentQuestionNum]
        if let que = question["question"] as? String {
            questionLabel.text = que
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

