//
//  AddNoteRoute.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 1.02.2022.
//

protocol AddNoteRoute {
    func pushAddNote(with note: NoteModel, updateNotList: ((NoteModel) -> Void)?)
}

extension AddNoteRoute where Self: RouterProtocol {
    
    func pushAddNote(with note: NoteModel, updateNotList: ((NoteModel) -> Void)?) {
        let router = AddNoteRouter()
        let viewModel = AddNoteViewModel(router: router, note: note, updateNotList: updateNotList)
        let viewController = AddNoteViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
