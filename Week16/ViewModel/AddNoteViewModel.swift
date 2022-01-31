//
//  AddNoteViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 31.01.2022.
//

import Foundation

struct AddNoteViewModel {
    
    private var noteList = [NoteModel]()
    
    func getNote(index: Int) -> NoteModel {
        return noteList[index]
    }

    mutating func setNoteList(list: [NoteModel]) {
        noteList = list
    }
}
