//
//  AddQuestionViewController.swift
//  MarubatsuApp
//
//  Created by 伴地慶介 on 2021/11/06.
//

import UIKit

class AddQuestionViewController: UIViewController {

    var questions: [[String: Any]] = []
    var maruBatsuFlg = false;

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "questions") != nil) {
            questions = userDefaults.object(forKey: "questions") as! [[String : Any]]
        }
        
        questionTextField.placeholder = "Please input questions..."
        
        segmentedControl.selectedSegmentTintColor = UIColor.blue
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: .normal)
        segmentedControl.layer.borderColor = UIColor.blue.cgColor
        segmentedControl.layer.borderWidth = 1
        
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        if questionTextField.text?.trimmingCharacters(in: .whitespaces) != "" {
            let userDefaults = UserDefaults.standard
            questions.append([
                "question": questionTextField.text ?? "",
                "answer": maruBatsuFlg
            ])
            userDefaults.set(questions, forKey: "questions")
            questionTextField.text = ""
            showAlert(title: "Save Question", message: "save aa question")
        } else {
            showAlert(title: "ERROR", message: "Please input question.")
        }
    }
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set([], forKey: "questions")
        showAlert(title: "Delete All", message: "delete all questions")
    }
    
    @IBAction func tapSegmentedControl(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            maruBatsuFlg = false
        case 1:
            maruBatsuFlg = true
        default:
            maruBatsuFlg = false
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}
