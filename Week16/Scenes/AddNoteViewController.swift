//
//  AddNoteViewController.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 28.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

protocol AddNoteViewControllerDelegate: AnyObject {
    func addNoteViewControllerWillPop(title: String, note: String, isEditMode: Bool)
}

class AddNoteViewController: UIViewController {
    
    weak var delegate: AddNoteViewControllerDelegate?
    
    var isEditMode = false
    var noteList = [NoteModel]()
    var selectedIndex = 0
    
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
    }
    
    private func configureContents() {
        self.title = "Ekle / Düzenle"
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        guard isEditMode else { return }
        titleTextField.text = noteList[selectedIndex].title
        noteTextField.text = noteList[selectedIndex].note
    }
}

// MARK: - SubViews
extension AddNoteViewController {
    
    private func addSubViews() {
        view.addSubview(noteStackView)
        noteStackView.addArrangedSubview(titleTextField)
        noteStackView.addArrangedSubview(noteTextField)
        noteStackView.topToSuperview().constant = 300
        noteStackView.edgesToSuperview(excluding: [.bottom, .top], insets: .init(top: 0, left: 100, bottom: 0, right: 100), usingSafeArea: true)
        
        view.addSubview(saveButton)
        saveButton.width(100)
        saveButton.aspectRatio(1)
        saveButton.centerInSuperview()
    }
}

// MARK: - Actions
extension AddNoteViewController {
    
    @objc
    func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let note = noteTextField.text, !note.isEmpty else {
                  return AlertViewGenerate.shared
                      .setViewController(self)
                      .setTitle(AlertIdentifier.error)
                      .setMessage(AlertIdentifier.missingData)
                      .generate()
              }
        if isEditMode {
            delegate?.addNoteViewControllerWillPop(title: title, note: note, isEditMode: true)
        } else {
            delegate?.addNoteViewControllerWillPop(title: title, note: note, isEditMode: false)
        }
        self.navigationController?.pop(options: .transitionCurlDown)
    }
}
