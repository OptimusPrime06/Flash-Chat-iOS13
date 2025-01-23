//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import CLTypingLabel
import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
       
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: Constants.BrandColors.blue)
        appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 25, weight: .black)
            ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = Constants.appName
        
    }

}

/* ======================= using for loop to create an animation ==============================

 titleLabel.text = ""
var charIndex = 0.0
let titletext = "⚡️FlashChat"
for letter in titletext {
    Timer.scheduledTimer(withTimeInterval: 0.12*charIndex, repeats: false) { (timer) in
        self.titleLabel.text?.append(letter)
    }
    charIndex += 1

}
 */
