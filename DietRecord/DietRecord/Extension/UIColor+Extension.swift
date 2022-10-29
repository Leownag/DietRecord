//
//  UIColor+Extension.swift
//  DietRecord
//
//  Created by chun on 2022/10/29.
//

import UIKit

private enum DRColor: String {
    case Yellow
    case Green
    case Orange
    case Blue
    case DarkBlue
    case Gray
}

extension UIColor {

    static let Yellow = DRColor(.Yellow)
    static let Green = DRColor(.Green)
    static let Orange = DRColor(.Orange)
    static let Blue = DRColor(.Blue)
    static let DarkBlue = DRColor(.DarkBlue)
    static let Gray = DRColor(.Gray)
    
    private static func DRColor(_ color: DRColor) -> UIColor {
        guard let DRcolor = UIColor(named: color.rawValue) else { return .gray}
        return DRcolor
    }

    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

