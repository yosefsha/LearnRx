//
//  OnboardingPairingBaseViewController.swift
//  MyMeSwift
//
//  Created by Leah Vogel on 08/10/2018.
//  Copyright © 2018 Orcam. All rights reserved.
//

import UIKit

class OnboardingPairingBaseViewController: BaseViewController {
    var mymeImageView = UIImageView()
    var titleLabel = UILabel()
    var nextButton = UIButton()
    var hideNextButton: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: Views
    func setupViews() {
        mymeImageView.contentMode = .scaleAspectFit
        view.addSubview(mymeImageView)
        mymeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mymeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mymeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mymeImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38),
            mymeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.22)
            ])
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            ])
        
        if !hideNextButton {

            nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
            
            view.addSubview(nextButton)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                nextButton.heightAnchor.constraint(equalToConstant: 45),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55)
                ])
        }
    }
    
    // MARK: - Actions
    @objc func nextButtonAction() {}
    
}
