//
//  NoteTableViewCellViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 2.02.2022.
//

import UIKit

protocol NoteTableViewCellDataSource: AnyObject {
    var title: String { get }
    var note: String { get }
}

protocol NoteTableViewCellProtocol: NoteTableViewCellDataSource {}

class NoteTableViewCellViewModel: NoteTableViewCellProtocol {
    
    var title: String
    var note: String
    
    init(with note: NoteModel) {
        self.title = note.title
        self.note = note.note
    }
}
