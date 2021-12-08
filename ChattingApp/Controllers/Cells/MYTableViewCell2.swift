//
//  MYTableViewCell2.swift
//  ChattingApp
//
//  Created by Lola M on 12/7/21.
//

import UIKit

class MYTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var msg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
