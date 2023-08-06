//
//  ViewController.swift
//  KirchbergConfetti
//
//  Created by Kirill Kostarev on 12.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myButton = UIButton(type: .system)

        myButton.setTitle("Tap on me", for: .normal)

        confetti.translatesAutoresizingMaskIntoConstraints = false
        myButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(confetti)
        self.view.addSubview(myButton)

        // Set button width and make it rounded
        let buttonWidth: CGFloat = 150
        myButton.layer.cornerRadius = 50 / 2
        myButton.clipsToBounds = true

        NSLayoutConstraint.activate([
            confetti.topAnchor.constraint(equalTo: view.topAnchor),
            confetti.rightAnchor.constraint(equalTo: view.rightAnchor),
            confetti.leftAnchor.constraint(equalTo: view.leftAnchor),
            confetti.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            myButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            myButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        myButton.addTarget(self, action: #selector(self.myButtonTapped(_:)), for: .touchUpInside)
    }

    @objc func myButtonTapped(_ sender: UIButton) {
        let impactEngine = UIImpactFeedbackGenerator(style: .heavy)
        impactEngine.impactOccurred()
        confetti.emit()
        print("Button tapped!")
    }

    private let confetti: ConfettiView = .top

}
