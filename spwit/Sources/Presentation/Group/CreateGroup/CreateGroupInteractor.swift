//
//  CreateGroupInteractor.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 02/08/25.
//

import UIKit

protocol CreateGroupInteractorProtocol: AnyObject {
    func postGroup()
    func nearby() -> [String]
}

class CreateGroupInteractor: CreateGroupInteractorProtocol{
    func postGroup() {
//        post group to api
    }
    
    func nearby() -> [String] {
        return ["Raiza", "Budi"] // dummy
    }
}
