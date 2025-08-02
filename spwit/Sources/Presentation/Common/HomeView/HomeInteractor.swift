//
//  HomeInteractor.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func fetchInitialState()
}
class HomeInteractor: HomeInteractorProtocol {
    func fetchInitialState() {
        //        fetch data from api
    }
}
