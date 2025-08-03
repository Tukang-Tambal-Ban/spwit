//
//  CreateNewSheetPresenter.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 01/08/25.
//
import UIKit

protocol CreateNewSheetPresenterProtocol: AnyObject {
    func didTapClose()
    func didTapGroup()
    func didTapPicture()
    func didTapManual()
}

class CreateNewSheetPresenter: CreateNewSheetPresenterProtocol {
    var router: CreateNewSheetRouterProtocol?
    weak var view: CreateNewSheetViewController?

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
