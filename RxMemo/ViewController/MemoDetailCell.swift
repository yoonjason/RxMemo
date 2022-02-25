//
//  MemoDetailCell.swift
//  RxMemo
//
//  Created by yoon on 2022/02/24.
//

import UIKit

class MemoDetailCell: UITableViewCell {

    static let reuseIdentifier = "MemoDetailCell"

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }

    func updateCell(_ title: String) {
        self.label.text = title
    }

}
