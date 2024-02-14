//
//  CompactControllerTransitioningDelegate.swift
//  CompactController
//
//  Created by Ian Baikuchukov on 14/2/24.
//

import UIKit

final class CompactControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let buttonFrame: CGRect
    
    init(buttonFrame: CGRect) {
        self.buttonFrame = buttonFrame
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(buttonFrame: buttonFrame, presentedViewController: presented, presenting: presenting)
    }
    
}
