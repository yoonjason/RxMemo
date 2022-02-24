//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoListViewModel!
    
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemoListCell.self, forCellReuseIdentifier: "MemoListCell")
        return tableView
    }()
    
    private lazy var addbutton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        return button
    }()
    
    func bindViewModel() {
        /**
         뷰모델에 저장되어있는 타이틀을 네비게이션 타이틀로 바인딩
         */
        viewModel.title.drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList.bind(to: listTableView.rx.items(cellIdentifier: MemoListCell.reuseIdentifier, cellType: MemoListCell.self)) { row, memo, cell in
            cell.updateCell(memo.content)
        }
        .disposed(by: rx.disposeBag)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    private func setupViews(){
        view.addSubview(listTableView)
        self.navigationItem.rightBarButtonItem = addbutton
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    
}
