//
//  NoteTableViewCell.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var noteLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
