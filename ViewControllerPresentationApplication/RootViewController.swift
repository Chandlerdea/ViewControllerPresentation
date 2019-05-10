//
//  ViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class RootViewController: UIViewController {
    
    @IBOutlet private weak var circleButton: UIButton!

    var transitionController: ViewControllerDefaultTransitionAnimationController? {
        didSet {
            self.transitionController?.tapDelegate = self
        }
    }

    private var peekTransitionController: UIViewControllerTransitioningDelegate = ViewControllerPeekTransitionAnimationController()
    private lazy var circleTransitionController: UIViewControllerTransitioningDelegate = ViewControllerCircleTransitionAnimationController(sourceFrame: self.circleButton.frame)
    
    private func presentOverlay(with entry: ViewControllerOverlay.Edge, completion: (() -> ())? = nil) {
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
        let vc = OverlayViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.transitionController
        self.present(vc, animated: true, completion: completion)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let recognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.view.addGestureRecognizer(recognizer)
    }
    
    public func peekNewViewController(animated: Bool, completion: (() -> ())? = nil) {
        let vc = PeekViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.peekTransitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    public func circleNewViewController(animated: Bool, completion: (() -> ())? = nil) {
        let vc = CirclePresentedViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.circleTransitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        self.peekNewViewController(animated: true)
    }
    
    public func didTapContainer() {
        self.presentedViewController?.dismiss(animated: true, completion: .none)
    }
    
    @IBAction func topButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .top)
    }
    
    @IBAction func leftButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .left)
    }
    
    @IBAction func bottomButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .bottom)
    }
    
    @IBAction func rightButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .right)
    }
    
    @IBAction func circleButtonSelected(_ sender: UIButton) {
        self.circleNewViewController(animated: true)
    }

}

