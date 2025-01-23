//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        self.emailTextfield.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        self.passwordTextfield.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

    }

    @IBAction func registerPressed(_ sender: UIButton) {

        if let email = emailTextfield.text,
            let password = passwordTextfield.text
        {
            Auth.auth().createUser(withEmail: email, password: password) {
                authResult, error in
                if let e = error {
                    self.showErrorAlert(message: e.localizedDescription)
                } else {
                    self.performSegue(
                        withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }

    }

    

}

extension UIViewController {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(
            title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

