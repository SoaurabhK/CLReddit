//
//  AddViewController.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

/// maxTitleLength is a constant representing maximum allowed length of the title String.
let maxTitleLength = 255

/// AddViewController is a subclass of UIViewController for configuring and managing the associated UIView i.e. for adding Posts.
class AddViewController: UIViewController, UITextFieldDelegate {
    
    /// postStore is an instance property which holds a reference to a store object.
    var postStore: PostStore!
    
    /// titleLabel is an outlet for a UILabel showing Title literal.
    @IBOutlet var titleLabel: UILabel!
    
    /// titleField is an outlet for a UITextField which gets title input from the user.
    @IBOutlet var titleField: UITextField!
    
    /// doneBtn is an outlet for a UIBarButtonItem which creates a Post with the input title. 
    @IBOutlet var doneBtn: UIBarButtonItem!
    
    /// errorLabel is an outlet for a UILabel to show error message when title's length increses more than 255 characters.
    @IBOutlet var errorLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide errorLabel and disable doneBtn on viewDidLoad.
        errorLabel.isHidden = true
        self.doneBtn.isEnabled = false
        
        //Set titleField delegate to self
        titleField.delegate = self
        
        //Listen for dynamic type change notification to adjust fonts based on change in device's accessibility settings.
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] notification in
            self?.titleField.font = .preferredFont(forTextStyle: .subheadline)
            self?.errorLabel.font = .preferredFont(forTextStyle: .subheadline)
            self?.titleLabel.font = .preferredFont(forTextStyle: .body)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Add Post
    
    /// addPost(_ sender:) is reponsible for creating post with the textField's text as title and pops out the current viewController.
    ///
    /// - Parameter sender: UIBarButtonItem object which triggers this action.
    @IBAction func addPost(_ sender: UIBarButtonItem) {
        if let text = titleField.text, text.characters.count > 0, text.characters.count <= maxTitleLength {
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
        
        //Remove self from observing dynamic type change notification.
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
        
        // Reject input characters if it's length gets more than 255 characters and show error message. 
        if finalLength > maxTitleLength {
            errorLabel.isHidden = false
            errorLabel.text = "Title cannot be more than 255 characters!"
            return false
        } else {
            errorLabel.isHidden = true
        }
        return true
    }
}
