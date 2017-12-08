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

    var transitionController: ViewControllerDefaultTransitionAnimationController? {
        didSet {
            self.transitionController?.tapDelegate = self
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let recognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        self.view.addGestureRecognizer(recognizer)
    }
    
    public func presentNewViewController(animated: Bool, completion: (() -> Void)? = nil) {
        let vc = PresentedViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.transitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        self.presentNewViewController(animated: true)
    }
    
    public func didTapContainer() {
        self.presentedViewController?.dismiss(animated: true, completion: .none)
    }
    
    private func present(with entry: ViewControllerOverlay.Edge) {
        let exit: ViewControllerOverlay.Edge
        let position: ViewControllerOverlay.Position
        switch entry {
        case .top:
            exit = .bottom
            position = .top(20)
        case .left:
            exit = .right
            position = .left(20)
        case .bottom:
            exit = .top
            position = .bottom(20)
        case .right:
            exit = .left
            position = .right(20)
        }
        let overlay: ViewControllerOverlay = try! ViewControllerOverlay(entry: entry, exit: exit, position: position)
        self.transitionController = ViewControllerOverlayTransitionAnimationController(overlay: overlay)
        self.presentNewViewController(animated: true)
    }
    
    @IBAction func topButtonSelected(_ sender: UIButton) {
        self.present(with: .top)
    }
    
    @IBAction func leftButtonSelected(_ sender: UIButton) {
        self.present(with: .left)
    }
    
    @IBAction func bottomButtonSelected(_ sender: UIButton) {
        self.present(with: .bottom)
    }
    
    @IBAction func rightButtonSelected(_ sender: UIButton) {
        self.present(with: .right)
    }

}

