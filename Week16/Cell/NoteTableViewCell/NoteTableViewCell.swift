//
//  NoteTableViewCell.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class NoteTableViewCell: UITableViewCell {
    
    let titleLabel = UILabelBuilder()
        .numberOfLines(0)
        .build()
    let noteLabel = UILabelBuilder()
        .numberOfLines(0)
        .build()
    
    weak var viewModel: NoteTableViewCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addSubViews() {
        addSubview(titleLabel)
        titleLabel.edgesToSuperview(insets: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    func setupCell(with viewModel: NoteTableViewCellProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        noteLabel.text = viewModel.note
    }
}
