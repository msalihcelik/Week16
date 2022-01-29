//
//  NoteListViewController.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 28.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class NoteListViewController: UIViewController {
    
    private let noteTableView = UITableViewBuilder().build()
    private let addNoteButton = UIButtonBuilder()
        .title("NOT EKLE")
        .titleFont(.boldSystemFont(ofSize: 22))
        .borderWidth(2)
        .borderColor(UIColor.black.cgColor)
        .cornerRadius(10)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addSubViews()
    }
    
    private func configureContents() {
        view.backgroundColor = .white
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SubViews
extension NoteListViewController {
    
    private func addSubViews() {
        view.addSubview(noteTableView)
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.edgesToSuperview(insets: .init(top: 0, left: 0, bottom: 100, right: 0), usingSafeArea: true)
        
        view.addSubview(addNoteButton)
        addNoteButton.topToBottom(of: noteTableView, offset: 10)
        addNoteButton.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 100, bottom: 10, right: 100), usingSafeArea: true)
    }
}

// MARK: - UITableViewDataSource methods
extension NoteListViewController: UITableViewDelegate { }
extension NoteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "123"
        return cell
    }
}

// MARK: - Actions
extension NoteListViewController {
    
    @objc
    func addNoteButtonTapped() {
        let viewController = AddNoteViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        self.present(viewController, animated: true, completion: nil)
    }
}
