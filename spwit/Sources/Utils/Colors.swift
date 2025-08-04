//
//  AppColor.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 02/08/25.
//

import UIKit
//
//extension UIColor {
//    static var darkBlue: UIColor {
//        return UIColor(named: "darkBlue") ?? .darkBlue
//    }
//
//    static var lightGreen: UIColor {
//        return UIColor(named: "lightGreen") ?? .lightGreen
//    }
//
//    static var grey: UIColor {
//        return UIColor(named: "grey") ?? .grey
//    }
//
//    static var minus: UIColor {
//        return UIColor(named: "minus") ?? .minus
//    }
//    
//    static var plus: UIColor {
//        return UIColor(named: "plus") ?? .plus
//    }
//    static var transparantGrey: UIColor {
//        return UIColor(named: "transparantGrey") ?? .transparantGrey
//    }
//
//    static var textGrey: UIColor {
//        return UIColor(named: "textGrey") ?? .textGrey
//    }
//}
extension UIColor {
    static var darkBlue: UIColor {
        return UIColor(named: "darkBlue") ?? UIColor(red: 0.059, green: 0.129, blue: 0.235, alpha: 1)
    }

    static var lightGreen: UIColor {
        return UIColor(named: "lightGreen") ?? UIColor(red: 0.643, green: 0.941, blue: 0, alpha: 1)
    }

    static var grey: UIColor {
        return UIColor(named: "grey") ?? UIColor(white: 0.6, alpha: 1)
    }

    static var minus: UIColor {
        return UIColor(named: "minus") ?? UIColor.red
    }

    static var plus: UIColor {
        return UIColor(named: "plus") ?? UIColor.green
    }

    static var transparantGrey: UIColor {
        return UIColor(named: "transparantGrey") ?? UIColor(white: 1, alpha: 0.1)
    }

    static var textGrey: UIColor {
        return UIColor(named: "textGrey") ?? UIColor(white: 0.8, alpha: 1)
    }
}
