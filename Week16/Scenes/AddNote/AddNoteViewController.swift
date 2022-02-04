//
//  AddNoteViewController.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 1.02.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

final class AddNoteViewController: BaseViewController<AddNoteViewModel> {
    
    private let noteStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    var titleTextField = UITextFieldBuilder()
        .placeholder("Title")
        .borderWidth(1)
        .build()
    var noteTextField = UITextFieldBuilder()
        .placeholder("Note")
        .borderWidth(1)
        .build()
    
    private let saveButton = UIButtonBuilder()
        .title("KAYDET")
        .borderWidth(2)
        .cornerRadius(5)
        .button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addSubViews()
        self.titleTextField.text = viewModel.title
        self.noteTextField.text = viewModel.note
    }
    
    private func configureContents() {
        self.title = ScreenTitles.AddNoteViewController
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
}

// MARK: - SubViews
extension AddNoteViewController {
    
    private func addSubViews() {
        view.addSubview(noteStackView)
        noteStackView.axis = .vertical
        noteStackView.addArrangedSubview(titleTextField)
        noteStackView.addArrangedSubview(noteTextField)
        noteStackView.topToSuperview().constant = 300
        noteStackView.edgesToSuperview(excluding: [.bottom, .top], insets: .init(top: 0, left: 100, bottom: 0, right: 100), usingSafeArea: true)
        titleTextField.setHugging(.required, for: .vertical)
        noteTextField.setHugging(.defaultLow, for: .vertical)
        
        view.addSubview(saveButton)
        saveButton.width(100)
        saveButton.aspectRatio(1)
        saveButton.centerXToSuperview()
        saveButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        saveButton.topToBottom(of: noteStackView, offset: 30)
    }
}

// MARK: - Actions
extension AddNoteViewController {
    
    @objc
    func saveButtonTapped() {
        if let title = titleTextField.text, !title.isEmpty,
           let note = noteTextField.text, !note.isEmpty {
            let model = NoteModel(title: title, note: note)
            viewModel.saveNote(note: model)
        } else {
            AlertViewGenerate.shared
                .setViewController(self)
                .setTitle(AlertIdentifier.error)
                .setMessage(AlertIdentifier.missingData)
                .generate()
        }
    }
}
