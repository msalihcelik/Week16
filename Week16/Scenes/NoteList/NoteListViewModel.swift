//
//  NoteListViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 1.02.2022.
//

import Foundation

protocol NoteListViewDataSource {
    var numberOfItems: Int { get }
    
    func cellItemAt(indexPath: IndexPath) -> NoteTableViewCellProtocol
}

protocol NoteListViewEventSource {
    var reloadData: (() -> Void)? { get set }
    var didUpdateTableViewRow: ((IndexPath) -> Void)? { get set }
}

protocol NoteListViewProtocol: NoteListViewDataSource, NoteListViewEventSource {
    func moveAddNote()
    func moveEditNote(at indexPath: IndexPath)
    func didRemoveNote(at indexPath: IndexPath)
}

final class NoteListViewModel: BaseViewModel<NoteListRouter>, NoteListViewProtocol {
    
    private var cellItems: [NoteTableViewCellProtocol] = []
    var didUpdateTableViewRow: ((IndexPath) -> Void)?
    var reloadData: (() -> Void)?
    
    init(router: NoteListRouter,
         note: NoteModel) {
        super.init(router: router)
        self.cellItems.append(NoteTableViewCellViewModel(with: note))
    }
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> NoteTableViewCellProtocol {
        return cellItems[indexPath.row]
    }
    
    func didRemoveNote(at indexPath: IndexPath) {
        cellItems.remove(at: indexPath.row)
    }
    
    func moveAddNote() {
        let model = NoteModel(title: "", note: "")
        router.pushAddNote(with: model) { [weak self] note in
            guard let self = self else { return }
            let noteItem = NoteTableViewCellViewModel(with: note)
            self.cellItems.insert(noteItem, at: 0)
            self.reloadData?()
        }
    }
    
    func moveEditNote(at indexPath: IndexPath) {
        let title = cellItems[indexPath.row].title
        let note = cellItems[indexPath.row].note
        let model = NoteModel(title: title, note: note)
        
        router.pushAddNote(with: model) { [weak self] note in
            guard let self = self else { return }
            let noteItem = NoteTableViewCellViewModel(with: note)
            self.cellItems[indexPath.row] = noteItem
            self.didUpdateTableViewRow?(indexPath)
        }
    }
}
