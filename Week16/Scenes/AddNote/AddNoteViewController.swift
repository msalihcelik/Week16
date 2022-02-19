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
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addSubViews()
    }
    
    private func configureContents() {
        title = ScreenTitles.AddNoteViewController
        view.backgroundColor = .white
        titleTextField.text = viewModel.title
        noteTextField.text = viewModel.note
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        noteTextField.contentVerticalAlignment = .top
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
        noteStackView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(100) + .right(100))
        titleTextField.setHugging(.required, for: .vertical)
        noteTextField.setHugging(.defaultLow, for: .vertical)
        
        view.addSubview(saveButton)
        saveButton.width(100)
        saveButton.aspectRatio(1)
        saveButton.centerXToSuperview()
        saveButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        saveButton.topToBottom(of: noteStackView, offset: 300)
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
