//
//  Scene.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/23.
//

import UIKit

enum Scene {
    case lsit(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}
/**
 스토리 보드에 있는 씬을 생성하고 연관값에 저장된 뷰모델을 바인딩해서 리턴하는 메서드를 구현한다.
 */
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        /**
         첫번재 리스트 블록에서 메모 목록씬을 생선한 다음에 뷰 모델을 바인딩해서 리턴한다.
         메모목록씬은 네비게이션 컨트롤러에 임베드 되어있는 첫번째 신이기 때문에 씬자체를 만드는게 아니고 네비게이션 컨트롤러를 만들어야한다.
         */
        switch self {
        case .lsit(let memoListViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewController else { fatalError() }
            listVC.bind(viewModel: memoListViewModel)
            
            return nav
            
        case .detail(let memoDetailViewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }
            detailVC.bind(viewModel: memoDetailViewModel)
            return detailVC
            
        case .compose(let memoComposeViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else  {
                fatalError()
            }
            composeVC.bind(viewModel: memoComposeViewModel)
            return nav
        }
    }
}
