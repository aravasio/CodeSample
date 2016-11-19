//
//  LoginViewController.swift
//  CodeSample
//
//  Created by Alejandro Ravasio on 11/16/16.
//  Copyright © 2016 Alejandro Ravasio. All rights reserved.
//

import UIKit
import RestEssentials


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldsContainer: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var showPasswordButton: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setKeyboardDismissal()
        setTitle()
        setContainerView()
        setUserField()
        setPasswordField()
        setLoginButton()
    }
    
    private func setKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    private func setTitle() {
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        titleLabel.textColor = UIColor.white
        let stringToBold = NSMutableAttributedString.init(string: "Puertos / Escobar")
        titleLabel.attributedText = boldSubstring(fromString: stringToBold, withStrings: "Puertos")
    }
    
    private func setContainerView() {
        textFieldsContainer.clipsToBounds = true
        textFieldsContainer.layer.cornerRadius = 10
        textFieldsContainer.layer.masksToBounds = true
    }
    
    private func setUserField() {
        usernameField.placeholder = "Username"
        usernameField.returnKeyType = .next
        usernameField.delegate = self //This delegation is to send the cursor immediately to the passwordField when pressin 'Next' in the keyboard
    }
    
    private func setPasswordField() {
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.delegate = self //This delegation is to override iOSs 'autoclear' of secureTextfields
    }
    
    private func setLoginButton() {
        loginButton.titleLabel?.text = "Login"
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func showPasswordPressed(_ sender: UIButton) {
        passwordField.isSecureTextEntry = false
    }
    
    @IBAction func showPasswordReleased(_ sender: UIButton) {
        var startPosition: UITextPosition?
        var endPosition: UITextPosition?
        
        // Remember the place where cursor was placed before switching secureTextEntry
        if let selectedRange = passwordField.selectedTextRange {
            startPosition = selectedRange.start
            endPosition = selectedRange.end
        }
        
        passwordField.isSecureTextEntry = true

        // After secureTextEntry has been changed
        if let start = startPosition {
            // Restoring cursor position
            passwordField.selectedTextRange = passwordField.textRange(from: start, to: start)
            if let end = endPosition {
                // Restoring selection (if there was any)
                passwordField.selectedTextRange = passwordField.textRange(from: start, to: end)
            }
        }
    }
    
    @IBAction func loginButtonWasPressed(_ sender: UIButton) {
        guard let username = usernameField.text else {
            //todo: color red the usernameField
            return
        }
        
        guard let password = passwordField.text else {
            //todo: color red the passwordField
            return
        }
        
        let login = Login(_user: username, _password: password)
        login.make(onSucess: {
            //TODO: Implement MainVC.
            //TODO: Take me there.
            OperationQueue.main.addOperation {
                let alert = UIAlertController(title: "Success!", message: "You logged in!", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        }, onFailure: {
            //TODO: Gracefully handle the login-error. Probably a small text message "usr/pwd wrong" or similar.
            OperationQueue.main.addOperation {
                let alert = UIAlertController(title: "Failed! :(", message: "Something went wrong...", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
    }
    
    // MARK: Delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //if we're working on the password field, do not allow the change between secure/insecure text to clear the field
        if textField === passwordField {
            if let start: UITextPosition = passwordField.position(from: textField.beginningOfDocument, offset: range.location),
                let end: UITextPosition = passwordField.position(from: start, offset: range.length),
                let textRange: UITextRange = passwordField.textRange(from: start, to: end){
                passwordField.replace(textRange, withText: string)
            }
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        }
        
        return true
    }
    
    
    // MARK: Helper Functions
    private func boldSubstring(fromString: NSMutableAttributedString, withStrings wordsToBold: String) -> NSMutableAttributedString {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        
        //Words to bold ought to be coma-separated.
        let words = wordsToBold.characters.split {$0 == ","}.map { String($0) }
        
        for word in words {
            let rangeOfItalicizedText = (fromString.string as NSString).range(of: word)
            fromString.addAttributes([NSFontAttributeName: font as Any], range: rangeOfItalicizedText)
        }
        
        return fromString
    }
    
}
