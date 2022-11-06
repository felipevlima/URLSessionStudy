//
//  IntroView.swift
//  AppViewCode
//
//  Created by Felipe Lima on 18/04/22.
//

import UIKit

class IntroView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubViews()
        constraintsHelloLabel()
        constraintsNameLabel()
        constraintsCrediCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = { value in
        let label = UILabel()
        label.text = value
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }("{devFelipe}")
    
    private lazy var creditCardView: CreditCardView = {
        let view = CreditCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    private func addSubViews() {
        addSubview(helloLabel)
        addSubview(nameLabel)
        addSubview(creditCardView)
    }
        
    private func constraintsHelloLabel(){
        let constrains = [
            helloLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        constrains.forEach {(item) in
            item.isActive = true
        }
        
    }
    
    private func constraintsNameLabel(){
        let constrains = [
            nameLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: helloLabel.centerXAnchor)
        ]
        
        constrains.forEach { item in
            item.isActive = true
        }
    }

    private func constraintsCrediCard() {
        let constrains = [
            creditCardView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 12),
            creditCardView.centerXAnchor.constraint(equalTo: helloLabel.centerXAnchor)
        ]

        constrains.forEach { item in
            item.isActive = true
        }
    }
}
