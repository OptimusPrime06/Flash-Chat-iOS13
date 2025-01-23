//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestoreInternal
import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!

    let db = Firestore.firestore()
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        navigationItem.hidesBackButton = true

        self.messageTextfield.attributedPlaceholder = NSAttributedString(
            string: "Write a message...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellIdentifier)

        loadMessages()
    }

    //MARK: - Loading earlier sent messages

    func loadMessages() {

        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener {
            querySnaoshot, error in

            self.messages = []

            if let e = error {
                print("Error \(e) While retrieving messages")
            } else {
                if let snapShotDocs = querySnaoshot?.documents {
                    for doc in snapShotDocs {
                        let data = doc.data()
                        if let messageSender = data[
                            Constants.FStore.senderField] as? String,
                            let messageBody = data[Constants.FStore.bodyField]
                                as? String
                        {
                            let newMessage = Message(
                                sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)

                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }

    //MARK: - Sending a message

    @IBAction func sendPressed(_ sender: UIButton) {

        if let messageBody = messageTextfield.text,
            let messageSender = Auth.auth().currentUser?.email
        {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]

            ) { (error) in
                if let e = error {
                    print("Error \(e) whle saving data")
                } else {
                    print("Data successfully saved")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
            
            
        }

    }

    //MARK: - Loging out

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {

        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}

//MARK: - Table View Data Source

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let message = messages[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as! MessageCell
        cell.label.text = message.body
        
        // message from current logged user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImaeView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            // message from another user
            cell.leftImaeView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        
        return cell
    }

}
