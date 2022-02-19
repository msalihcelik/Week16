//
//  AddNoteViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 1.02.2022.
//

import Foundation

protocol AddNoteViewDataSource {
    var title: String { get set }
    var note: String { get set }
}

protocol AddNoteViewEventSource {}

protocol AddNoteViewProtocol: AddNoteViewDataSource, AddNoteViewEventSource {
    func saveNote(note: NoteModel)
}

final class AddNoteViewModel: BaseViewModel<AddNoteRouter>, AddNoteViewProtocol {
    
    private let updateNotList: ((NoteModel) -> Void)?
    var title: String
    var note: String

    init(router: AddNoteRouter,
         note: NoteModel,
         updateNotList: ((NoteModel) -> Void)?) {
        self.title = note.title
        self.note = note.note
        self.updateNotList = updateNotList
        super.init(router: router)
    }
    
    func saveNote(note: NoteModel) {
        self.updateNotList?(note)
        router.close(completion: nil)
    }
}
