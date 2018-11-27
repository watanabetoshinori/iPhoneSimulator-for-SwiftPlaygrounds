//
//  SimulatorDevice.swift
//  iPhoneSimulator
//
//  Created by Watanabe Toshinori on 9/7/18.
//  Copyright © 2018 Watanabe Toshinori. All rights reserved.
//

import UIKit

public enum SimulatorOrientation: Int {
    case portrait = 0
    case landscape
}

public enum SimulatorDevice: Int {
    case iPhone8Plus = 0
    case iPhoneX
    case iPhone8
    case iPhoneSE
    case iPhone4S
    
    var name: String {
        switch self {
        case .iPhone8Plus:
            return "iPhone 8Plus"
        case .iPhoneX:
            return "iPhone X"
        case .iPhone8:
            return "iPhone 8"
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhone4S:
            return "iPhone 4S"
        }
    }
    
    func size(with orientation: SimulatorOrientation) -> CGSize {
        let size: CGSize = {
            switch self {
            case .iPhone8Plus:
                return CGSize(width: 414, height: 736)
            case .iPhoneX:
                return CGSize(width: 375, height: 734)
            case .iPhone8:
                return CGSize(width: 375, height: 667)
            case .iPhoneSE:
                return CGSize(width: 320, height: 568)
            case .iPhone4S:
                return CGSize(width: 320, height: 420)
            }
        }()
        
        if orientation == .portrait {
            return size
        } else {
            return CGSize(width: size.height, height: size.width)
        }
    }
    
    func trait(with orientation: SimulatorOrientation) -> UITraitCollection {
        if orientation == .portrait {
            return .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])

        } else {
            switch self {
            case .iPhone8Plus:
                return .init(traitsFrom: [
                    .init(horizontalSizeClass: .regular),
                    .init(verticalSizeClass: .compact),
                    .init(userInterfaceIdiom: .phone)
                    ])
            default:
                return .init(traitsFrom: [
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .compact),
                    .init(userInterfaceIdiom: .phone)
                    ])
            }
        }
    }
    
    func traitsDescription(with orientation: SimulatorOrientation) -> String {
        if orientation == .portrait {
            return "(wC hR)"
            
        } else {
            switch self {
            case .iPhone8Plus:
                return "(wR hC)"

            default:
                return "(wC hC)"
            }
        }
    }

}
