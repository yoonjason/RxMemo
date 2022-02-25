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

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemoListCell.self, forCellReuseIdentifier: MemoListCell.reuseIdentifier)
        return tableView
    }()

    private var addbutton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        return button
    }()

    func bindViewModel() {
        /**
         뷰모델에 저장되어있는 타이틀을 네비게이션 타이틀로 바인딩
         */
        viewModel.title.drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.memoList
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)

        addbutton.rx.action = viewModel.makeCreateAction()

        /**
         테이블 뷰에서 메모를 선택하면 뷰모델을 통해서 디테일 액션을 전달하고, 선택된 셀을 선택해제
         */
        //rxswift 6
        /**
         - withUnretained(self): self에 대한 비소유참조와 zip연산자가 방출하는 요소가 다시 하나의 튜플로 합쳐져서 방출됨.
         - 클로져 캡쳐 리스트가 삭제 가능하고, tuple의 첫번째요소는 self = ViewController, 두번째 요소는 데이터가 된다.
            데이터에는 튜플로 담겨져 있고, (indexPath, data)가 된다.
         */
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Memo.self))
            .withUnretained(self)
            .do(onNext: { (vc, data) in
            vc.tableView.deselectRow(at: data.0, animated: true)
        })
            .map { $0.1.1 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)

        //rxswift 5
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Memo.self)).bind { [weak self] indexPath, memo in
//            self?.tableView.deselectRow(at: indexPath, animated: true)
//
//        }
//        .disposed(by: rx.disposeBag)

        tableView.rx.modelDeleted(Memo.self)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
        
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }

    private func setupViews() {
        view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = addbutton
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }



}
