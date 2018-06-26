//
//  WorksTableViewController.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import UIKit

class WorksTableViewController: UITableViewController, WorksView {
    
    var configurator = WorksConfiguratorImplementation()
    var presenter: WorksPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(worksTableViewController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    
    @IBAction func addButtonPressed(_ sender: Any) {
        presenter.addButtonPressed()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfWorks
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as! WorkTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return presenter.canEdit(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return presenter.titleForDeleteButton(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        presenter.deleteButtonPressed(row: indexPath.row)
    }
    
    // MARK: - WorksView
    
    func refreshWorksView() {
        tableView.reloadData()
    }
    
    func displayWorksRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
    
    func deleteAnimated(row: Int) {
        tableView.deleteRows(at: [IndexPath(row: row, section:0)], with: .automatic)
    }
    
    func endEditing() {
        tableView.setEditing(false, animated: true)
    }
    
    func displayWorkDeleteError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }

}
