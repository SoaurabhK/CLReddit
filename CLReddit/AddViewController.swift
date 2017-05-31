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
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
        
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
    
}
