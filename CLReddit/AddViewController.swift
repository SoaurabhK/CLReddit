//
//  AddViewController.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    var postStore: PostStore!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var doneBtn: UIBarButtonItem!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
        self.doneBtn.isEnabled = false
        
        //Set titleField delegate to self
        titleField.delegate = self
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] notification in
            self?.titleField.font = .preferredFont(forTextStyle: .subheadline)
            self?.errorLabel.font = .preferredFont(forTextStyle: .subheadline)
            self?.titleLabel.font = .preferredFont(forTextStyle: .body)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: UIBarButtonItem) {
        if let text = titleField.text, text.characters.count > 0, text.characters.count <= 255 {
            postStore.createPost(title: text)
        }
        
        //Dismiss the viewController
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    // MARK: - Dismiss the keyboard
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIContentSizeCategoryDidChange, object: nil)
    }

}

 // MARK: - TextField Delegates
extension AddViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //To prevent "undo" bug
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        //Final text length should not be greater than 255 characters
        let finalLength = currentCharacterCount + string.characters.count - range.length
        
        // Done button is only enabled if final text length is greater than zero.
        self.doneBtn.isEnabled = (finalLength > 0) ? true : false
        
        if finalLength > 255 {
            errorLabel.isHidden = false
            errorLabel.text = "Title cannot be more than 255 characters!"
            return false
        } else {
            errorLabel.isHidden = true
        }
        return true
    }
}
