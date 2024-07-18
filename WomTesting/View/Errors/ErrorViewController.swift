//
//  ErrorViewController.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 18-07-24.
//
import UIKit

class ErrorViewController: UIViewController {

    var retryAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let errorLabel = UILabel()
        errorLabel.text = "Ocurrio un error en la Aplicacion."
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(errorLabel)
        view.addSubview(retryButton)

        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func retry() {
        retryAction?()
        dismiss(animated: true, completion: nil)
    }
}
