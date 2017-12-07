//
//  ViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class RootViewController: UIViewController, ViewControllerTransitionPresentationDelegate {

    let transitionController: ViewControlllerTransitionAnimationController = ViewControlllerTransitionAnimationController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.transitionController.tapDelegate = self
        let recognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        self.view.addGestureRecognizer(recognizer)
    }
    
    public func presentNewViewController(animated: Bool, completion: @escaping () -> Void) {
        let vc = PresentedViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.transitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        self.presentNewViewController(animated: true) {}
    }
    
    public func didTapContainer() {
        self.presentedViewController?.dismiss(animated: true, completion: .none)
    }

}

