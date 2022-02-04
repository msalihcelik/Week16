//
//  NoteListViewController.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 1.02.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class NoteListViewController: BaseViewController<NoteListViewModel> {
    
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
        subscribeViewModel()
    }
}

// MARK: - UILayout
extension NoteListViewController {
    
    private func addSubViews() {
        view.addSubview(noteTableView)
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        view.addSubview(addNoteButton)
        addNoteButton.width(150)
        addNoteButton.height(100)
        addNoteButton.centerXToSuperview()
        addNoteButton.bottomToSuperview(offset: -10, usingSafeArea: true)
        addNoteButton.topToBottom(of: noteTableView, offset: 30)
    }
}

// MARK: - Configure & SetLocalize
extension NoteListViewController {
    
    private func configureContents() {
        self.title = ScreenTitles.NoteListViewController
        view.backgroundColor = .white
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: CellIdentifier.noteCell)
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SubscribeViewModel
extension NoteListViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.noteTableView.reloadData()
        }
        viewModel.didUpdateTableViewRow = { [weak self] indexPath in
            self?.noteTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
// MARK: - Actions
extension NoteListViewController {
    
    @objc
    func addNoteButtonTapped() {
        viewModel.moveAddNote()
    }
}

// swiftlint:disable line_length
// MARK: - UITableViewDataSource
extension NoteListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = noteTableView.dequeueReusableCell(withIdentifier: CellIdentifier.noteCell, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        let note = viewModel.cellItemAt(indexPath: indexPath)
        cell.setupCell(with: note)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Warning", message: "Do you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.viewModel.didRemoveNote(at: indexPath)
                self.noteTableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        let editButton = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            self?.viewModel.moveEditNote(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteButton, editButton])
    }
}
// swiftlint:enable line_length
