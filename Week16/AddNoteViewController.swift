//
//  AddNoteViewController.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 28.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class AddNoteViewController: UIViewController {
    
    private let noteStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    private let titleTextField = UITextFieldBuilder()
        .placeholder("Title")
        .borderWidth(1)
        .build()
    private let noteTextField = UITextFieldBuilder()
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
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
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
        self.dismiss(animated: true, completion: nil)
    }
}
