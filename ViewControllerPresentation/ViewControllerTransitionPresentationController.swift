//
//  ViewControllerTransitionPresentationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/06/17.
//

import UIKit

public protocol ViewControllerTransitionPresentationDelegate: class {
    func didTapContainer()
}

final class ViewControllerTransitionPresentationController: UIPresentationController {

    // MARK: - Properties

    weak var tapDelegate: ViewControllerTransitionPresentationDelegate?

    private let dimmingView: UIView

    // MARK: - Computed Properties

    override var shouldPresentInFullscreen: Bool {
        return true
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let containerSize: CGSize = self.containerView?.bounds.size ?? UIScreen.main.bounds.size
        let presentedViewSize: CGSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerSize)
        return CGRect(
            x: (containerSize.width * 0.5) - (presentedViewSize.width * 0.5),
            y: containerSize.height - presentedViewSize.height,
            width: presentedViewSize.width,
            height: presentedViewSize.height
        )
    }

    // MARK: - Init

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.dimmingView = UIView(frame: .zero)
        self.dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapRecognized(_:)))
        self.dimmingView.addGestureRecognizer(tapRecognizer)
    }

    // MARK: - Public Methods

    @objc func tapRecognized(_ sender: UITapGestureRecognizer) {
        self.tapDelegate?.didTapContainer()
    }

    override func presentationTransitionWillBegin() {
        self.containerView?.addSubview(self.dimmingView)
        guard let coordinator: UIViewControllerTransitionCoordinator = self.presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 1
            return
        }
        self.dimmingView.alpha = 0
        coordinator.animate(alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView.alpha = 1
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator: UIViewControllerTransitionCoordinator = self.presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0
            return
        }
        self.dimmingView.alpha = 1
        coordinator.animate(alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView.alpha = 0
        })
    }

    override func containerViewWillLayoutSubviews() {
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        guard let containerView: UIView = self.containerView else { return }
        self.dimmingView.frame = containerView.bounds
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.preferredContentSize
    }
}
