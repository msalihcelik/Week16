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
    
    private var selectedIndex = 0
    private var noteListViewModel = NoteListViewModel()
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
        self.title = TitleIdentifier.NoteListViewController
        view.backgroundColor = .white
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: CellIdentifier.noteCell)
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        noteListViewModel.addNote(title: "Test", note: "Test")
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

// MARK: - Actions
extension NoteListViewController {
    
    @objc
    func addNoteButtonTapped() {
        let addNoteViewController = AddNoteViewController()
        addNoteViewController.delegate = self
        self.navigationController?.push(nextViewController: addNoteViewController, options: .transitionCurlUp)
    }
}

// MARK: - AddNoteViewControllerDelegate
extension NoteListViewController: AddNoteViewControllerDelegate {
    
    func addNoteViewControllerWillPop(title: String, note: String, isEditMode: Bool) {
        if isEditMode {
            self.noteListViewModel.editNote(title: title, note: note, index: selectedIndex)
        } else {
            self.noteListViewModel.addNote(title: title, note: note)
        }
        self.noteTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource methods
extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] _, _ in
            guard let self = self else { return }
            let addNoteViewController = AddNoteViewController()
            addNoteViewController.delegate = self
            addNoteViewController.isEditMode = true
            addNoteViewController.addNoteViewModel.setNoteList(list: self.noteListViewModel.getNoteList())
            addNoteViewController.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(addNoteViewController, animated: true)
        }
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { [weak self] _, _ in
            guard let self = self else { return }
            self.noteListViewModel.removeNote(index: indexPath.row)
            self.noteTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        editButton.backgroundColor = UIColor.lightGray
        deleteButton.backgroundColor = UIColor.darkGray
        return [deleteButton, editButton]
    }
}

// MARK: - UITableViewDelegete methods
extension NoteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteListViewModel.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.noteCell, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = noteListViewModel.getNote(index: indexPath.row).title
        return cell
    }
}
