//
//  NoteViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import Foundation

struct NoteListViewModel {
    
    private var noteList = [NoteModel]()
    
    func count() -> Int {
        return noteList.count
    }
    
    func getNote(index: Int) -> NoteModel {
        return noteList[index]
    }
    
    mutating func addNote(title: String, note: String) {
        let model = NoteModel(title: title, note: note)
        noteList.insert(model, at: 0)
    }
    
    mutating func editNote(title: String, note: String, index: Int) {
        noteList[index] = NoteModel(title: title, note: note)
    }
    
    mutating func removeNote(index: Int) {
        noteList.remove(at: index)
    }
    
    func getNoteList() -> [NoteModel] {
        return noteList
    }
}
