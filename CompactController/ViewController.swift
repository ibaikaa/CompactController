//
//  ViewController.swift
//  CompactController
//
//  Created by Ian Baikuchukov on 14/2/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var presentControllerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(presentControllerButton)
        presentControllerButton.translatesAutoresizingMaskIntoConstraints = false
        presentControllerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        presentControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc
    private func presentController() {
        let vc = CompactViewController()
        vc.delegate = self
        
        let transitioningDelegate = CompactControllerTransitioningDelegate(buttonFrame: presentControllerButton.frame)
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioningDelegate
        
        presentControllerButton.tintAdjustmentMode = .dimmed
        
        self.present(vc, animated: false) {
            UIView.animate(withDuration: 0.5) {
                vc.view.alpha = 1
            }
        }
    }

}

extension ViewController: CompactViewControllerDelegate {
    func didDismissCompactViewController() {
        presentControllerButton.tintAdjustmentMode = .normal
    }
}
