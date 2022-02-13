//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/4/22.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        // passing in different SF symbols, this allows for aligning as it fills the image view
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            // slightly bigger than font of 14
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 15),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }

    func set(itemInfoType: ItemInfoType, withCount: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image =  SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image =  SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image =  SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image =  SFSymbols.following
            titleLabel.text = "Following"
        }
        // no need to switch for case since applies to all
        countLabel.text = String(withCount)
    }
}
