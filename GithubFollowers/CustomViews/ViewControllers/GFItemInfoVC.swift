//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/5/22.
//

import UIKit

// superclass for layout and other generic stuff
class GFItemInfoVC: UIViewController {
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    // don't initialize backgroundColor, text, etc. in superclass, rather in each subclass
    let actionButton = GFButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
		configureStackView()
	}

    private func configureBackgroundView() {
        view.layer.cornerRadius = 15
        view.backgroundColor = .secondarySystemBackground
    }
	
	private func configureStackView(){
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		// spacing between stackView.spacing is a property as well
		
		stackView.addArrangedSubview(itemInfoViewOne)
		stackView.addArrangedSubview(itemInfoViewTwo)
	}

	// again, nice to leave this toward bottom, deal with logic higher up
    private func layoutUI() {
        // no need to add itemInfoViewOne/Two as they will be added via stack view
        view.addSubview(stackView)
        view.addSubview(actionButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
