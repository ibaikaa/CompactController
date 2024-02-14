//
//  CompactViewController.swift
//  CompactController
//
//  Created by Ian Baikuchukov on 14/2/24.
//

import UIKit

protocol CompactViewControllerDelegate: AnyObject {
    func didDismissCompactViewController()
}

final class CompactViewController: UIViewController {
    
    weak var delegate: CompactViewControllerDelegate?
    
    private let heightOptions: [CGFloat] = [280, 150]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: heightOptions.map { "\(Int($0))pt" } )
        view.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
        
        return view
    }()
    
    private lazy var dismissControllerButton: UIButton = {
        let view = UIButton(type: .close)
        view.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size.height = heightOptions[0]
        
        view.alpha = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
    
        setupSubviews()
        drawPointer()
        addShadow()
    }
    
    private func setupSubviews() {
        view.addSubview(segmentedControl)
        segmentedControl.frame = CGRect(
            x: view.bounds.midX - segmentedControl.frame.width / 2,
            y: view.bounds.minY + 5,
            width: segmentedControl.frame.width,
            height: segmentedControl.frame.height
        )
        
        view.addSubview(dismissControllerButton)
        dismissControllerButton.frame = CGRect(
            x: view.bounds.maxX - 50,
            y: view.bounds.minY + 5,
            width: segmentedControl.frame.height,
            height: segmentedControl.frame.height
        )
    }
    
    private func drawPointer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.position = CGPoint(x: view.bounds.minX, y: view.bounds.minY)
        shapeLayer.fillColor = UIColor.systemGray6.cgColor
        shapeLayer.lineWidth = 1
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: view.bounds.midX - 15, y: view.bounds.minY))
        bezierPath.addLine(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY - 15))
        bezierPath.addLine(to: CGPoint(x: view.bounds.midX + 15, y: view.bounds.minY))
        
        shapeLayer.path = bezierPath.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
    
    private func addShadow() {
        view.layer.shadowColor = UIColor.systemGray.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    @objc 
    private func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.size.height = self.heightOptions[sender.selectedSegmentIndex]
        }
    }
    
    @objc
    private func dismissController() {
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false) {
                self.delegate?.didDismissCompactViewController()
            }
        }
    }
    
}
