//
//  Cell.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/24.
//

import Foundation
import UIKit


class MemoListCell: UITableViewCell {

    static let reuseIdentifier = "MemoListCell"

    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViews() {
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19)
            ])
    }

    func updateCell(_ title: String) {
        self.title.text = title
    }

}
