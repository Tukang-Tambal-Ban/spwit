//
//  HomePageProtocols.swift
//  spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 31/07/25.
//
protocol HomePageProtocol: AnyObject{
    func showWelcomeMessage()
}
protocol HomePagePresenterProtocol: AnyObject{
    func viewDidLoad()
    func didTapAddButton()
    func didTapProfileButton()
    
}
protocol HomePageInteractorProtocol: AnyObject{
    
}
protocol HomePageRouterProtocol: AnyObject{
    
}
