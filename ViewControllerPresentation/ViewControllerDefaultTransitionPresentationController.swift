//
//  ViewControllerTransitionPresentationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/06/17.
//

import UIKit

class ViewControllerDefaultTransitionPresentationController: UIPresentationController {

    // MARK: - Properties

    weak var tapDelegate: ViewControllerTransitionPresentationDelegate?

    private var dimmingView: UIView?
    private var customBackgroundView: UIView?
    
    private let backgroundView: UIView

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

    init(backgroundColor: UIColor?, backgroundView: UIView?, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        if let backgroundColor: UIColor = backgroundColor {
            let dimmingView = UIView(frame: .zero)
            dimmingView.backgroundColor = backgroundColor
            self.backgroundView = dimmingView
        } else if let backgroundView: UIView = backgroundView {
            self.backgroundView = backgroundView
        } else {
            fatalError("either backgroundColor or backgroundView must not be nil")
        }
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapRecognized(_:)))
        self.backgroundView.addGestureRecognizer(tapRecognizer)
    }

    // MARK: - Public Methods

    @objc func tapRecognized(_ sender: UITapGestureRecognizer) {
        self.tapDelegate?.didTapContainer()
    }

    override func presentationTransitionWillBegin() {
        self.containerView?.addSubview(self.backgroundView)
        guard let coordinator: UIViewControllerTransitionCoordinator = self.presentedViewController.transitionCoordinator else {
            self.backgroundView.alpha = 1
            return
        }
        self.backgroundView.alpha = 0
        coordinator.animate(alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in
            self.backgroundView.alpha = 1
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator: UIViewControllerTransitionCoordinator = self.presentedViewController.transitionCoordinator else {
            self.backgroundView.alpha = 0
            return
        }
        self.backgroundView.alpha = 1
        coordinator.animate(alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in
            self.backgroundView.alpha = 0
        })
    }

    override func containerViewWillLayoutSubviews() {
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        guard let containerView: UIView = self.containerView else { return }
        self.backgroundView.frame = containerView.bounds
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.preferredContentSize
    }
}
