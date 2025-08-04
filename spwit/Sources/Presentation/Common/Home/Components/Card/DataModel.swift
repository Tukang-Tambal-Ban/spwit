//
//  DataModel.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

// FOR DUMMY ONLY
import UIKit

struct GroupCardViewModel {
    let groupName: String
    let memberCount: Int
    let statusText: String?
    let statusAmount: String?
    let statusType: StatusType   
    
    enum StatusType {
        case settled
        case lent
        case owe
        case none
    }
}

