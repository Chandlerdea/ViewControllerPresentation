//
//  PeekViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

class PeekViewController: UIViewController {
    

    public override var preferredContentSize: CGSize {
        get {
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height - 60
            )
        }
        set {}
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
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
    
    @objc func closeSelected(_ sender: UIButton) {
        self.dismiss(animated: true, completion: .none)
    }

}
