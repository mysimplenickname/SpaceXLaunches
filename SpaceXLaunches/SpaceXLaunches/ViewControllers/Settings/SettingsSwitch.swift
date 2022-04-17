//
//  SettingsSwitch.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import UIKit

class SettingsSwitch: UIControl {
    
    private lazy var thumbView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var onLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var offLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
        
    private var onPoint: CGPoint = .zero
    private var offPoint: CGPoint = .zero
    
    private var isAnimating = false
    
    var isOn: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animate()
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            
            layer.cornerRadius = frame.height / 4
            
            let padding: CGFloat = 2
            
            let thumbSize = CGSize(width: frame.width / 2 - padding * 2, height: frame.height - padding * 2)
            let yPostition = (frame.height - thumbSize.height) / 2
            
            onPoint = CGPoint(x: frame.width - thumbSize.width - padding, y: yPostition)
            offPoint = CGPoint(x: padding, y: yPostition)
            
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.layer.cornerRadius = thumbSize.height / 4
            
            let labelWidth = bounds.width / 2
            onLabel.frame = CGRect(x: 0.0, y: 0.0, width: labelWidth, height: frame.height)
            offLabel.frame = CGRect(x: frame.width - labelWidth, y: 0.0, width: labelWidth, height: frame.height)
            
        }
        
    }
    
    func setOn(on: Bool, animated: Bool) {
        
        switch animated {
        case true:
            animate(on: on)
        case false:
            isOn = on
            setupViewsOnAction()
            completeAction()
        }
    }
 
    private func setupUI() {
        
        backgroundColor = .darkGray2
        
        addSubview(thumbView)
        
        let frameLength = frame.width / 2
        onLabel.frame = CGRect(x: 0.0, y: 0.0, width: frameLength, height: frame.height)
        offLabel.frame = CGRect(x: frameLength, y: 0.0, width: frameLength, height: frame.height)
        
        insertSubview(onLabel, aboveSubview: thumbView)
        insertSubview(offLabel, aboveSubview: thumbView)

    }
    
    private func animate(on: Bool? = nil) {
        
        isOn = on ?? !isOn
        
        isAnimating = true
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [
                UIView.AnimationOptions.curveEaseOut,
                UIView.AnimationOptions.beginFromCurrentState,
                UIView.AnimationOptions.allowUserInteraction
            ],
            animations: {
                self.setupViewsOnAction()
            
            }, completion: { _ in
                self.completeAction()
            }
        )
        
    }
    
    private func setupViewsOnAction() {
        
        if isOn {
            thumbView.frame.origin.x = onPoint.x
            onLabel.textColor = .white
            offLabel.textColor = .black
        } else {
            thumbView.frame.origin.x = offPoint.x
            onLabel.textColor = .black
            offLabel.textColor = .white
        }
        
    }
    
    private func completeAction() {
        isAnimating = false
        sendActions(for: UIControl.Event.valueChanged)
    }
    
}
