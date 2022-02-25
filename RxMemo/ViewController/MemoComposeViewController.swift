//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import UIKit

import Action
import NSObject_Rx
import RxCocoa
import RxSwift

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        return button
    }()

    private var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        return button
    }()

    var viewModel: MemoComposeViewModel!

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.initialText
            .drive(textView.rx.text)
            .disposed(by: rx.disposeBag)

        cancelButton.rx.action = viewModel.cancelAction

        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(textView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)

        let wilShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }

        let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { noti -> CGFloat in 0 }
        /**
         노티피케이션이 전달되는 시점마다 키보드 높이 방출
         */
        let keyboardObservable = Observable.merge(wilShowObservable, willHideObservable)
            .share()
        
        
        keyboardObservable
            .withUnretained(textView)
            .subscribe(onNext: { tv, height in
                var inset = tv.contentInset
                inset.bottom = height
                tv.contentInset = inset
                
                var scrollInset = tv.verticalScrollIndicatorInsets
                scrollInset.bottom = height
                tv.verticalScrollIndicatorInsets = scrollInset
            })
            .disposed(by: rx.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }

    func setupViews() {
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }



}
