//
//  WorksPresenter.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
protocol WorksView: class {
    func refreshWorksView()
    func displayWorksRetrievalError(title: String, message: String)
    func displayWorkDeleteError(title: String, message: String)
    func deleteAnimated(row: Int)
    func endEditing()
}

// It would be fine for the cell view to declare a WorkCellViewModel property and have it configure itself
// Using this approach makes the view even more passive/dumb - but I can understand if some might consider it an overkill
protocol WorkCellView {
    func display(title: String)
    func display(author: String)
    func display(releaseDate: String)
}

protocol WorksPresenter {
    var numberOfWorks: Int { get }
    var router: WorksViewRouter { get }
    func viewDidLoad()
    func configure(cell: WorkCellView, forRow row: Int)
    func didSelect(row: Int)
    func canEdit(row: Int) -> Bool
    func titleForDeleteButton(row: Int) -> String
    func deleteButtonPressed(row: Int)
    func addButtonPressed()
}

class WorksPresenterImplementation: WorksPresenter {
    fileprivate weak var view: WorksView?
    fileprivate let displayWorksUseCase: DisplayWorksUseCase
    fileprivate let deleteWorkUseCase: DeleteWorkUseCase
    internal let router: WorksViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var works = [Work]()
    
    var numberOfWorks: Int {
        return works.count
    }
    
    init(view: WorksView,
         displayWorksUseCase: DisplayWorksUseCase,
         deleteWorkUseCase: DeleteWorkUseCase,
         router: WorksViewRouter) {
        self.view = view
        self.displayWorksUseCase = displayWorksUseCase
        self.deleteWorkUseCase = deleteWorkUseCase
        self.router = router
        
        registerForDeleteWorkNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - WorksPresenter
    
    func viewDidLoad() {
        self.displayWorksUseCase.displayWorks { (result) in
            switch result {
            case let .success(Works):
                self.handleWorksReceived(Works)
            case let .failure(error):
                self.handleWorksError(error)
            }
        }
    }
    
    func configure(cell: WorkCellView, forRow row: Int) {
        let work = works[row]
        
//        cell.display(title: work.title)
//        cell.display(author: work.author)
//        cell.display(releaseDate: work.releaseDate?.relativeDescription() ?? "Unknown")
    }
    
    func didSelect(row: Int) {
        let work = works[row]
        
        router.presentDetailsView(for: work)
    }
    
    func canEdit(row: Int) -> Bool {
        return true
    }
    
    func titleForDeleteButton(row: Int) -> String {
        return "Delete Work"
    }
    
    func deleteButtonPressed(row: Int) {
        view?.endEditing()
        
        let Work = works[row]
        deleteWorkUseCase.delete(work: Work) { (result) in
            switch result {
            case .success():
                self.handleWorkDeleted(Work: Work)
            case let .failure(error):
                self.handleWorkDeleteError(error)
            }
        }
    }
    
    func addButtonPressed() {
//        router.presentAddWork(addWorkPresenterDelegate: self)
    }
    
    // MARK: - AddWorkPresenterDelegate
    
//    func addWorkPresenter(_ presenter: AddWorkPresenter, didAdd work: Work) {
//        presenter.router.dismiss()
//        works.append(work)
//        view?.refreshWorksView()
//    }
//
//    func addWorkPresenterCancel(presenter: AddWorkPresenter) {
//        presenter.router.dismiss()
//    }
    
    // MARK: - Private
    
    fileprivate func handleWorksReceived(_ Works: [Work]) {
        self.works = Works
        view?.refreshWorksView()
    }
    
    fileprivate func handleWorksError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayWorksRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    fileprivate func registerForDeleteWorkNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveDeleteWorkNotification),
                                               name: DeleteWorkUseCaseNotifications.didDeleteWork,
                                               object: nil)
    }
    
    @objc fileprivate func didReceiveDeleteWorkNotification(_ notification: Notification) {
        if let Work = notification.object as? Work {
            handleWorkDeleted(Work: Work)
        }
    }
    
    fileprivate func handleWorkDeleted(Work: Work) {
        // The Work might have already be deleted due to the notification response
        if let row = works.index(of: Work) {
            works.remove(at: row)
            view?.deleteAnimated(row: row)
        }
    }
    
    fileprivate func handleWorkDeleteError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayWorkDeleteError(title: "Error", message: error.localizedDescription)
    }
}
