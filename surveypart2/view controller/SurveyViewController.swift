//
//  SurveyViewController.swift
//  surveypart2
//
//  Created by Brian Licea on 10/5/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    // Mark: -outlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emojiTextfield: UITextField!
    
    // Mark: - action
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let emoji = emojiTextfield.text, name != "", !emoji.isEmpty
            else { return }
        
        SurveyController.shared.putSurvey(with: name, emoji: emoji) { (success) in
            guard success else { return }
            DispatchQueue.main.async {
                // clears out the textfields
                self.nameTextField.text = ""
                self.emojiTextfield.text = ""
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
