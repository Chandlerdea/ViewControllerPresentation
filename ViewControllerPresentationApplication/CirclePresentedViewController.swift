//
//  CirclePresentedViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 5/9/19.
//  Copyright © 2019 Chandlerdea. All rights reserved.
//

import UIKit

final class CirclePresentedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCloseButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeCloseButton()
    }
    
    private func addCloseButton() {
        let closeButton: UIButton = UIButton(type: .custom)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        closeButton.addTarget(
            self,
            action: #selector(self.closeSelected(_:)),
            for: .touchUpInside
        )
    }
    
    private func removeCloseButton() {
        self.view.subviews.first?.removeFromSuperview()
    }
    
    @objc func closeSelected(_ sender: UIButton) {
        self.dismiss(animated: true, completion: .none)
    }

}
