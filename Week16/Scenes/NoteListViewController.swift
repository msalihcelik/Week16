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
    private var noteList = [NoteModel]()
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
        self.title = "Not Listesi"
        view.backgroundColor = .white
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "noteCell")
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        noteList.append(NoteModel(title: "qqq", note: "www"))
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
        let model = NoteModel(title: title, note: note)
        if isEditMode {
                    self.noteList[selectedIndex] = model
                } else {
                    self.noteList.insert(model, at: 0)
                }
        self.noteTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource methods
extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] _, _ in
            guard let self = self else { return }
            let addNoteViewController = AddNoteViewController()
            addNoteViewController.delegate = self
            addNoteViewController.isEditMode = true
            addNoteViewController.noteList = self.noteList
            addNoteViewController.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(addNoteViewController, animated: true)
        }
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { [weak self] _, _ in
            guard let self = self else { return }
            self.noteList.remove(at: indexPath.row)
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
        noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = noteList[indexPath.row].title
        return cell
    }
}
