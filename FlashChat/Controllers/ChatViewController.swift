//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Marisha Deroubaix on 23/08/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  var messageArray : [Message] = [Message]()

  @IBOutlet weak var heightConstraint: NSLayoutConstraint!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var messageTextfield: UITextField!
  @IBOutlet weak var messageTableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.delegate = self
        messageTableView.dataSource = self
    
        messageTextfield.delegate = self
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    messageTableView.addGestureRecognizer(tapGesture)
    
    
    
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
    
    configureTableView()
    retrieveMessages()
    
    messageTableView.separatorStyle = .none
    
    }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    
    cell.messageBody.text = messageArray[indexPath.row].messageBody
    cell.senderUsername.text = messageArray[indexPath.row].sender
    cell.avatarImage.image = UIImage(named: "Avatar")
    
    if cell.senderUsername.text == Auth.auth().currentUser?.email as String?  {
      
      cell.avatarImage.backgroundColor = UIColor.flatPlum()
      cell.messageBackground.backgroundColor = UIColor.flatMint()

    } else {
      
      cell.avatarImage.backgroundColor = UIColor.flatBlue()
      cell.messageBackground.backgroundColor = UIColor.flatWatermelon()
    }
    
    return cell
  }
  
  @objc func tableViewTapped() {
    messageTextfield.endEditing(true)
  }
  
  func configureTableView() {
    messageTableView.rowHeight = UITableViewAutomaticDimension
    messageTableView.estimatedRowHeight = 120.0
  }
  
  //MARK:- TextField Delegate Methods
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    UIView.animate(withDuration: 0.5){
      self.heightConstraint.constant = 308
      self.view.layoutIfNeeded()
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    UIView.animate(withDuration: 0.5) {
      self.heightConstraint.constant = 50
      self.view.layoutIfNeeded()
    }
    
  }
    

  @IBAction func sendPressed(_ sender: UIButton) {
    
    messageTextfield.endEditing(true)
    
    messageTextfield.isEnabled = false
    sendButton.isEnabled = false
    
    let messagesDB = Database.database().reference().child("Messages")
    
    let messageDictionary = ["Sender" : Auth.auth().currentUser?.email,
                             "MessageBody" : messageTextfield.text!]
    messagesDB.childByAutoId().setValue(messageDictionary) {
      (error, reference) in
      
      if error != nil {
        print(error!)
      } else {
        print("Message saved successfully!")
        
        self.messageTextfield.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextfield.text = ""
      }
    }
    
  }
  
  func retrieveMessages() {
    let messageDB = Database.database().reference().child("Messages")
    
    messageDB.observe(.childAdded, with:  { (snapshot) in
      let snapshotValue = snapshot.value as! Dictionary<String, String>
      
      let text = snapshotValue["MessageBody"]!
      let sender = snapshotValue["Sender"]!
      
      let message = Message()
      message.messageBody = text
      message.sender = sender
      
      self.messageArray.append(message)
      
      self.configureTableView()
      self.messageTableView.reloadData()
    })
  }
  
  @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
    
    do {
      try Auth.auth().signOut()
      navigationController?.popToRootViewController( animated: true)
      
    } catch {
      print("error, there was a problem signing out.")
    }
    
    }
  
  }

