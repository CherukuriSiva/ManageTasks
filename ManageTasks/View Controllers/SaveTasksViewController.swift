//
//  SaveTasksViewController.swift
//  ManageTasks
//
//  Created by Apple on 28/10/16.
//  Copyright © 2016 Cherukuri. All rights reserved.
//

import UIKit

class SaveTasksViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskNameTextField.delegate = self;
        taskDescriptionTextField.delegate = self;
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveTaskClicked(_ sender: AnyObject) {
        
        if taskNameTextField.text == "" || taskDescriptionTextField.text == "" {
            // either textfield task or description's text is empty
            let alert = UIAlertController(title: "Error", message: "Please enter task details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }else{
            
            var tasksArray = UserDefaults.standard.object(forKey: "SavedTasksArray") as? [Dictionary <String, String>] ?? [Dictionary <String, String>]()
            
            if tasksArray.isEmpty {
                tasksArray = [Dictionary <String, String>]()
            }
            
            var tagsArray = [Dictionary <String, String>]()
            tagsArray+=tasksArray
            tagsArray.append(["taskName": taskNameTextField.text!, "taskDescription": taskDescriptionTextField.text!])
            
            UserDefaults.standard.set(tagsArray, forKey: "SavedTasksArray")
            UserDefaults.standard.synchronize()
            
            taskNameTextField.text = ""
            taskDescriptionTextField.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

