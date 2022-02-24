//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!

    private let toolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        return toolBar
    }()

    private var trashButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        button.tintColor = .red
        return button
    }()

    private var plexibleLeftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        return button
    }()
    private var plexibleRightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        return button
    }()

    private var composeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        button.tintColor = .red
        return button
    }()

    private var shareButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        button.tintColor = .red
        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.register(MemoDetailCell.self, forCellReuseIdentifier: MemoDetailCell.reuseIdentifier)
        return tableView
    }()


    func bindViewModel() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(toolbar)
        toolbar.items = [
            trashButton,
            plexibleLeftButton,
            composeButton,
            plexibleRightButton,
            shareButton
        ]

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -toolbar.frame.size.height),
            
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}
