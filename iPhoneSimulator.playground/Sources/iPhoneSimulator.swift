//
//  iPhoneSimulator.swift
//  iPhoneSimulator
//
//  Created by Watanabe Toshinori on 9/7/18.
//  Copyright © 2018 Watanabe Toshinori. All rights reserved.
//

import UIKit

public class iPhoneSimulator: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var statusBarView: UIView!

    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var deviceView: UIView!

    @IBOutlet weak var deviceLabel: UILabel!

    @IBOutlet weak var deviceListView: UIView!

    @IBOutlet weak var deviceListBottomConstraint: NSLayoutConstraint!

    @IBOutlet var deviceButtons: [UIButton]!

    @IBOutlet weak var orientationPortraitButton: UIButton!

    @IBOutlet weak var orientationLandscapeButton: UIButton!

    var containerView: UIView!

    // MARK: - Variables

    var viewController: UIViewController!

    var device: SimulatorDevice!

    var orientation: SimulatorOrientation = .portrait {
        didSet {
            orientationPortraitButton.isHidden = orientation != .portrait
            orientationLandscapeButton.isHidden = orientation != .landscape
        }
    }

    // MARK: - Running Simulator
    
    /***
     For iOS Simulator
     */
    public class func run(window: UIWindow, device: SimulatorDevice = .iPhone8) {
        guard let rootViewController = window.rootViewController else {
            fatalError("Missing rootViewController.")
        }
        
        let simulator = iPhoneSimulator.liveView(with: rootViewController, device: device)
        
        window.rootViewController = simulator
    }
    
    /***
     For Playground
     */
    public class func liveView(with viewController: UIViewController, device: SimulatorDevice = .iPhone8) -> iPhoneSimulator {
        let simulator = iPhoneSimulator()
        simulator.loadLayouts()
        simulator.device = .iPhone8
        simulator.preferredContentSize = CGSize(width: 768, height: 768)

        simulator.addChild(viewController)
        simulator.containerView.addSubview(viewController.view)
        viewController.view.frame.size = simulator.containerView.frame.size

        return simulator
    }

    // MARK: - Laytout subviews

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        reload()
    }

    // MARK: - Navigation

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, segue.identifier) {
        case (let containerViewController, "ContainerViewController"?):
            containerViewController.addChild(viewController)
            containerViewController.view.addSubview(viewController.view)
            viewController.view.frame = containerViewController.view.frame
        default:
            break
        }
    }

    // MARK: - Actions

    @IBAction func deviceTapped(_ sender: Any) {
        let isDeviceListShown = deviceListBottomConstraint.constant == 0

        if isDeviceListShown {
            hideDeviceList()
        } else {
            showDeviceList()
        }
    }

    @IBAction func deviceImageTapped(_ sender: UIButton) {
        device = SimulatorDevice(rawValue: sender.tag) ?? .iPhone8
        reload()
    }

    @IBAction func orientationTapped(_ sender: UIButton) {
        if orientation == .portrait {
            orientation = .landscape
        } else {
            orientation = .portrait
        }
        reload()
    }

    // MARK: - Reloading View layout

    private func reload() {
        let traitDescription = device.traitsDescription(with: orientation)
        deviceLabel.text = "View as: \(device.name) \(traitDescription)"

        // Resize app root view
        let deviceSize = device.size(with: orientation)
        containerWidthConstraint.constant = deviceSize.width
        containerHeightConstraint.constant = deviceSize.height

        // Update traits
        let deviceTraits = device.trait(with: orientation)
        children.forEach { (viewController) in
            viewController.children.forEach { (childViewController) in
                viewController.setOverrideTraitCollection(deviceTraits, forChild: childViewController)
            }
        }

        deviceButtons.forEach { (button) in
            button.tintColor = (button.tag == device.rawValue) ? UIColor(red: 48/255, green: 110/255, blue: 237/255, alpha: 1.0) : .black
        }
    }

    // MARK: - Managing DeviceList

    private func showDeviceList() {
        view.layoutIfNeeded()

        deviceListBottomConstraint.constant = 0

        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func hideDeviceList(_ completion: (() -> Void)? = nil) {
        view.layoutIfNeeded()

        deviceListBottomConstraint.constant = 121

        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()

        }) { _ in
            completion?()
        }
    }


    // 
    // Auto-Generated by storyboard2code (https://github.com/watanabetoshinori/storyboard2code)
    // 

    func loadLayouts() {
        
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(red: 0.25098234415054321, green: 0.25097692012786865, blue: 0.25098058581352234, alpha: 1)
        view.frame = CGRect(x: 0.0, y: 0.0, width: 768, height: 1024)
        view.autoresizingMask = UIView.AutoresizingMask(arrayLiteral: [.flexibleHeight, .flexibleWidth])
        
        /* eH6-8P-Utb */
        containerView = UIView(frame: .zero)
        containerView.contentMode = .scaleToFill
        containerView.isOpaque = false
        containerView.frame = CGRect(x: 196.5, y: 180.5, width: 375, height: 663)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        /* nMl-cc-MIx */
        let view2 = UIView(frame: .zero)
        view2.contentMode = .scaleToFill
        view2.backgroundColor = UIColor(red: 0.20784479379653931, green: 0.20784014463424683, blue: 0.20784327387809753, alpha: 1)
        view2.frame = CGRect(x: 0.0, y: 1004, width: 768, height: 141)
        view2.translatesAutoresizingMaskIntoConstraints = false
        
        /* pWe-Hz-de7 */
        let view3 = UIView(frame: .zero)
        view3.contentMode = .scaleToFill
        view3.backgroundColor = UIColor(red: 0.20784479379653931, green: 0.20784014463424683, blue: 0.20784327387809753, alpha: 1)
        view3.frame = CGRect(x: 0.0, y: 0.0, width: 768, height: 20)
        view3.translatesAutoresizingMaskIntoConstraints = false
        
        /* sFB-d6-Rkf */
        let label = UILabel(frame: .zero)
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        label.textColor = UIColor(white: 1, alpha: 1)
        label.isOpaque = false
        label.frame = CGRect(x: 311, y: 2, width: 146.5, height: 16)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "View as: iPhone (wR cR)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .natural
        label.baselineAdjustment = .alignBaselines
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        view3.addSubview(label)
        view2.addSubview(view3)
        
        /* KW9-44-5qc */
        let view4 = UIView(frame: .zero)
        view4.contentMode = .scaleToFill
        view4.backgroundColor = UIColor(red: 0.25490391254425049, green: 0.25489839911460876, blue: 0.25490215420722961, alpha: 1)
        view4.frame = CGRect(x: 0.0, y: 20, width: 768, height: 1)
        view4.translatesAutoresizingMaskIntoConstraints = false
        view2.addSubview(view4)
        
        /* d7D-rA-aZ2 */
        let stackView = UIStackView(frame: .zero)
        stackView.contentMode = .scaleToFill
        stackView.isOpaque = false
        stackView.frame = CGRect(x: 102, y: 29, width: 564, height: 104)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 40
        
        /* 3kj-Cw-HJo */
        let stackView2 = UIStackView(frame: .zero)
        stackView2.contentMode = .scaleToFill
        stackView2.isOpaque = false
        stackView2.frame = CGRect(x: 0.0, y: 0.0, width: 395, height: 104)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.axis = .vertical
        stackView2.alignment = .center
        stackView2.spacing = 4
        
        /* gHG-vu-06G */
        let stackView3 = UIStackView(frame: .zero)
        stackView3.contentMode = .scaleToFill
        stackView3.backgroundColor = UIColor(red: 0.20784479380000001, green: 0.2078401446, blue: 0.20784327389999999, alpha: 1)
        stackView3.isOpaque = false
        stackView3.frame = CGRect(x: 0.0, y: 0.0, width: 395, height: 84)
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.alignment = .center
        stackView3.distribution = .fillEqually
        stackView3.spacing = 40
        
        /* xfC-so-wqP */
        let button = UIButton(frame: .zero)
        button.contentMode = .scaleToFill
        button.tintColor = UIColor(red: 0.18823529411764706, green: 0.43137254901960786, blue: 0.92941176470588238, alpha: 1)
        button.isOpaque = false
        button.frame = CGRect(x: 0.0, y: 0.0, width: 47, height: 84)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iPhone8Plus", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button.addTarget(self, action: Selector("deviceImageTapped:"), for: .touchUpInside)
        stackView3.addArrangedSubview(button)
        
        /* nXh-Pe-lFd */
        let button2 = UIButton(frame: .zero)
        button2.contentMode = .scaleToFill
        button2.tag = 1
        button2.isOpaque = false
        button2.frame = CGRect(x: 87, y: 0.0, width: 47, height: 84)
        button2.contentHorizontalAlignment = .center
        button2.contentVerticalAlignment = .center
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.setImage(UIImage(named: "iPhoneX", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button2.addTarget(self, action: Selector("deviceImageTapped:"), for: .touchUpInside)
        stackView3.addArrangedSubview(button2)
        
        /* 7rn-UK-aF3 */
        let button3 = UIButton(frame: .zero)
        button3.contentMode = .scaleToFill
        button3.tag = 2
        button3.isOpaque = false
        button3.frame = CGRect(x: 174, y: 0.0, width: 47, height: 84)
        button3.contentHorizontalAlignment = .center
        button3.contentVerticalAlignment = .center
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.setImage(UIImage(named: "iPhone8", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button3.addTarget(self, action: Selector("deviceImageTapped:"), for: .touchUpInside)
        stackView3.addArrangedSubview(button3)
        
        /* MfD-iT-g5s */
        let button4 = UIButton(frame: .zero)
        button4.contentMode = .scaleToFill
        button4.tag = 3
        button4.isOpaque = false
        button4.frame = CGRect(x: 261, y: 0.0, width: 47, height: 84)
        button4.contentHorizontalAlignment = .center
        button4.contentVerticalAlignment = .center
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.setImage(UIImage(named: "iPhoneSE", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button4.addTarget(self, action: Selector("deviceImageTapped:"), for: .touchUpInside)
        stackView3.addArrangedSubview(button4)
        
        /* oW2-EA-mmH */
        let button5 = UIButton(frame: .zero)
        button5.contentMode = .scaleToFill
        button5.tag = 4
        button5.isOpaque = false
        button5.frame = CGRect(x: 348, y: 0.0, width: 47, height: 84)
        button5.contentHorizontalAlignment = .center
        button5.contentVerticalAlignment = .center
        button5.translatesAutoresizingMaskIntoConstraints = false
        button5.setImage(UIImage(named: "iPhone4S", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button5.addTarget(self, action: Selector("deviceImageTapped:"), for: .touchUpInside)
        stackView3.addArrangedSubview(button5)
        stackView2.addArrangedSubview(stackView3)
        
        /* 95q-pL-x5e */
        let label2 = UILabel(frame: .zero)
        label2.contentMode = .left
        label2.isUserInteractionEnabled = false
        label2.textColor = UIColor(white: 1, alpha: 1)
        label2.isOpaque = false
        label2.frame = CGRect(x: 177, y: 88, width: 41.5, height: 16)
        label2.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label2.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Device"
        label2.font = UIFont.systemFont(ofSize: 13)
        label2.textAlignment = .center
        label2.baselineAdjustment = .alignBaselines
        label2.lineBreakMode = .byTruncatingTail
        label2.adjustsFontSizeToFitWidth = false
        stackView2.addArrangedSubview(label2)
        stackView.addArrangedSubview(stackView2)
        
        /* 9Tn-cX-0SA */
        let stackView4 = UIStackView(frame: .zero)
        stackView4.contentMode = .scaleToFill
        stackView4.backgroundColor = UIColor(red: 0.20784479380000001, green: 0.2078401446, blue: 0.20784327389999999, alpha: 1)
        stackView4.isOpaque = false
        stackView4.frame = CGRect(x: 435, y: 0.0, width: 129, height: 104)
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        stackView4.alignment = .center
        stackView4.spacing = 40
        
        /* LxQ-Ag-7W1 */
        let view5 = UIView(frame: .zero)
        view5.contentMode = .scaleToFill
        view5.backgroundColor = UIColor(red: 0.2549039125, green: 0.25489839910000001, blue: 0.25490215420000001, alpha: 1)
        view5.frame = CGRect(x: 0.0, y: 8, width: 1, height: 88)
        view5.translatesAutoresizingMaskIntoConstraints = false
        stackView4.addArrangedSubview(view5)
        
        /* dG6-WW-VT1 */
        let stackView5 = UIStackView(frame: .zero)
        stackView5.contentMode = .scaleToFill
        stackView5.isOpaque = false
        stackView5.frame = CGRect(x: 41, y: 0.0, width: 88, height: 104)
        stackView5.translatesAutoresizingMaskIntoConstraints = false
        stackView5.axis = .vertical
        stackView5.alignment = .center
        stackView5.spacing = 4
        
        /* MD1-mk-vhw */
        let stackView6 = UIStackView(frame: .zero)
        stackView6.contentMode = .scaleToFill
        stackView6.isOpaque = false
        stackView6.frame = CGRect(x: 0.0, y: 0.0, width: 88, height: 84)
        stackView6.translatesAutoresizingMaskIntoConstraints = false
        stackView6.alignment = .top
        
        /* mca-kJ-sht */
        let button6 = UIButton(frame: .zero)
        button6.contentMode = .scaleToFill
        button6.tag = 4
        button6.isOpaque = false
        button6.frame = CGRect(x: 0.0, y: 0.0, width: 88, height: 84)
        button6.contentHorizontalAlignment = .center
        button6.contentVerticalAlignment = .center
        button6.translatesAutoresizingMaskIntoConstraints = false
        button6.setImage(UIImage(named: "OrientationPortrait", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button6.addTarget(self, action: Selector("orientationTapped:"), for: .touchUpInside)
        stackView6.addArrangedSubview(button6)
        
        /* o7p-hV-EZK */
        let button7 = UIButton(frame: .zero)
        button7.contentMode = .scaleToFill
        button7.tag = 4
        button7.isOpaque = false
        button7.isHidden = true
        button7.frame = CGRect(x: 0.0, y: 0.0, width: 88, height: 88)
        button7.contentHorizontalAlignment = .center
        button7.contentVerticalAlignment = .center
        button7.translatesAutoresizingMaskIntoConstraints = false
        button7.setImage(UIImage(named: "OrientationLandscape", in: Bundle(for: iPhoneSimulator.self), compatibleWith: nil), for: .normal)
        button7.addTarget(self, action: Selector("orientationTapped:"), for: .touchUpInside)
        stackView6.addArrangedSubview(button7)
        stackView5.addArrangedSubview(stackView6)
        
        /* osg-mC-gyM */
        let label3 = UILabel(frame: .zero)
        label3.contentMode = .left
        label3.isUserInteractionEnabled = false
        label3.textColor = UIColor(white: 1, alpha: 1)
        label3.isOpaque = false
        label3.frame = CGRect(x: 10.5, y: 88, width: 67.5, height: 16)
        label3.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label3.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "Orientation"
        label3.font = UIFont.systemFont(ofSize: 13)
        label3.textAlignment = .center
        label3.baselineAdjustment = .alignBaselines
        label3.lineBreakMode = .byTruncatingTail
        label3.adjustsFontSizeToFitWidth = false
        stackView5.addArrangedSubview(label3)
        stackView4.addArrangedSubview(stackView5)
        stackView.addArrangedSubview(stackView4)
        view2.addSubview(stackView)
        view.addSubview(view2)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("deviceTapped:"))
        
        /* CaX-Pw-qij */
        let constraint = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 121)
        view.addConstraint(constraint)
        /* LZz-m2-Hxk */
        let constraint2 = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint2)
        /* M2H-v3-uGb */
        let constraint3 = NSLayoutConstraint(item: view2, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint3)
        /* ZHg-im-fWq */
        let constraint4 = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint4)
        /* eKu-jw-gS4 */
        let constraint5 = NSLayoutConstraint(item: view2, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint5)
        /* 5Fj-P5-ige */
        let constraint6 = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 663)
        containerView.addConstraint(constraint6)
        /* XCW-3H-2JT */
        let constraint7 = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 375)
        containerView.addConstraint(constraint7)
        /* 8gD-SU-zZP */
        let constraint8 = NSLayoutConstraint(item: view3, attribute: .leading, relatedBy: .equal, toItem: view2, attribute: .leading, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint8)
        /* E0r-lo-P9K */
        let constraint9 = NSLayoutConstraint(item: view4, attribute: .leading, relatedBy: .equal, toItem: view2, attribute: .leading, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint9)
        /* GKH-kW-aej */
        let constraint10 = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: view4, attribute: .bottom, multiplier: 1.0, constant: 8)
        view2.addConstraint(constraint10)
        /* RNN-R0-ZmH */
        let constraint11 = NSLayoutConstraint(item: view2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 141)
        view2.addConstraint(constraint11)
        /* Vy7-0f-zQ3 */
        let constraint12 = NSLayoutConstraint(item: view2, attribute: .trailing, relatedBy: .equal, toItem: view4, attribute: .trailing, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint12)
        /* YxI-Ud-nm6 */
        let constraint13 = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: stackView, attribute: .bottom, multiplier: 1.0, constant: 8)
        view2.addConstraint(constraint13)
        /* d65-G7-nSo */
        let constraint14 = NSLayoutConstraint(item: view2, attribute: .trailing, relatedBy: .equal, toItem: view3, attribute: .trailing, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint14)
        /* g6u-tc-cns */
        let constraint15 = NSLayoutConstraint(item: view3, attribute: .top, relatedBy: .equal, toItem: view2, attribute: .top, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint15)
        /* je4-gt-ubs */
        let constraint16 = NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view2, attribute: .centerX, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint16)
        /* pII-eE-RIZ */
        let constraint17 = NSLayoutConstraint(item: view4, attribute: .top, relatedBy: .equal, toItem: view3, attribute: .bottom, multiplier: 1.0, constant: 0)
        view2.addConstraint(constraint17)
        /* L6N-FM-bHk */
        let constraint18 = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view3, attribute: .centerX, multiplier: 1.0, constant: 0)
        view3.addConstraint(constraint18)
        /* PZw-Ah-NF9 */
        let constraint19 = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view3, attribute: .centerY, multiplier: 1.0, constant: 0)
        view3.addConstraint(constraint19)
        /* sh5-h6-ID7 */
        let constraint20 = NSLayoutConstraint(item: view3, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        view3.addConstraint(constraint20)
        /* pkk-4D-al3 */
        let constraint21 = NSLayoutConstraint(item: view4, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
        view4.addConstraint(constraint21)
        /* hGm-zr-ygs */
        let constraint22 = NSLayoutConstraint(item: label2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 16)
        label2.addConstraint(constraint22)
        /* cSE-NO-oFT */
        let constraint23 = NSLayoutConstraint(item: view5, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
        view5.addConstraint(constraint23)
        /* yk9-4N-LTB */
        let constraint24 = NSLayoutConstraint(item: view5, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 88)
        view5.addConstraint(constraint24)
        /* jGD-6c-xfm */
        let constraint25 = NSLayoutConstraint(item: button6, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 88)
        button6.addConstraint(constraint25)
        /* aPK-Rk-o6y */
        let constraint26 = NSLayoutConstraint(item: button7, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 88)
        button7.addConstraint(constraint26)
        /* xVU-0J-xlj */
        let constraint27 = NSLayoutConstraint(item: label3, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 16)
        label3.addConstraint(constraint27)
        
        self.deviceButtons = []
        self.containerHeightConstraint = constraint6
        self.containerWidthConstraint = constraint7
        self.deviceLabel = label
        self.deviceListBottomConstraint = constraint
        self.deviceListView = view2
        self.deviceView = view3
        self.orientationLandscapeButton = button7
        self.orientationPortraitButton = button6
        self.deviceButtons.append(button5)
        self.deviceButtons.append(button2)
        self.deviceButtons.append(button4)
        self.deviceButtons.append(button)
        self.deviceButtons.append(button3)
        view3.gestureRecognizers = []
        view3.addGestureRecognizer(tapGestureRecognizer)
    }
    
}
