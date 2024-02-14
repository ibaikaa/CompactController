//
//  PresentationController.swift
//  CompactController
//
//  Created by Ian Baikuchukov on 14/2/24.
//

import UIKit

final class PresentationController: UIPresentationController {
    
    let buttonFrame: CGRect
    
    override var shouldPresentInFullscreen: Bool { false }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(x: buttonFrame.midX - 150, y: buttonFrame.maxY + 20, width: 300, height: 280)
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        guard let containerView else { return }
        
        containerView.setNeedsLayout()
    }
    
    init(buttonFrame: CGRect, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.buttonFrame = buttonFrame
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
}
