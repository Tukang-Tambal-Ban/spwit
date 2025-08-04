//
//  DataModel.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

// FOR DUMMY ONLY
import UIKit

enum GroupCardStatus {
    case settled, lent, owe, none
}

struct GroupCardModel {
    let groupName: String
    let memberCount: Int
    let statusText: String
    let statusAmount: String?
    let statusType: GroupCardStatus
}
