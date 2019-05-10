//
//  PeekViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class PeekViewController: UIViewController, ViewControllerPresentable, ViewControllerModalInteractiveDismissable {
    
    var customBackgroundView: UIView? {
        return .none
    }
    
    var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    var interactiveTransitioning: ViewControllerModalInteractiveDismissalController?
    
    func swipeDidBegin() {

    }
    
    func swipeDidEnd() {
        if self.interactiveTransitioning?.shouldCompleteTransition == true {
            self.dismiss(animated: true, completion: .none)
        }
    }

    override var preferredContentSize: CGSize {
        get {
            var result: CGSize = UIScreen.main.bounds.size
            var isPhoneX: Bool = false
            if #available(iOS 11.0, *) {
                if let appDelegate: UIApplicationDelegate = UIApplication.shared.delegate,
                    let mainWindow: UIWindow? = appDelegate.window,
                    let insets: UIEdgeInsets = mainWindow?.safeAreaInsets {
                    isPhoneX = insets.top > 0
                }
            }
            result.height -= isPhoneX ? 52 : 40
            return result
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.interactiveTransitioning = ViewControllerModalInteractiveDismissalController(viewController: self)
        self.addCloseButton()
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
    
    @objc func closeSelected(_ sender: UIButton) {
        self.dismiss(animated: true, completion: .none)
    }

}
