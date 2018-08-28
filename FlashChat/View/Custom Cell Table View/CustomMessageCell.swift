//
//  CustomMessageCell.swift
//  FlashChat
//
//  Created by Marisha Deroubaix on 27/08/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var messageBackground: UIView!
  @IBOutlet weak var messageBody: UILabel!
  @IBOutlet weak var senderUsername: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
