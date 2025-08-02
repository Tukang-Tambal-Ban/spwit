//
//  SheetPresenter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 01/08/25.
//
import UIKit

protocol SheetPresenterProtocol: AnyObject {
    func didTapClose()
    func didTapGroup()
    func didTapPicture()
    func didTapManual()
}

class SheetPresenter: SheetPresenterProtocol {
    var router: SheetsRouterProtocol?
    weak var view: SheetsViewController?
    
    func didTapClose() {
        router?.dismiss()
    }
    
    func didTapGroup() {
        router?.navigateToCreateGroup()
    }
    
    func didTapPicture() {
        router?.navigateToTakePict()
    }
    
    func didTapManual() {
        router?.navigateToCreateExpenses()
    }
    
    
}
