//
//  LocationTableViewController.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 08/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

protocol NotesTableViewControllerDelegate : class {
    /**
     Delegate method to search note on the base of search text
     */
    func searchNotesWithText(searchText : String , completion: ([Note]) -> Void)
    
    /**
     Delegate method indicating that focus on map location where this note is pinned
     */
    func moveToNote(note : Note)
}

final class NotesTableViewController: UITableViewController {

    
     weak var delegate :NotesTableViewControllerDelegate?
    
    var notesTableVM : NotesTableModeling! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableVM = NotesTableViewModel()
        setUpTableView()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 80.0;
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return notesTableVM.getSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesTableVM.getRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if notesTableVM.isShowNoNoteAvailableCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.string, for: indexPath) as! NotesTableViewCell
        cell.configureCell(with: notesTableVM.getNote(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if notesTableVM.isShowNoNoteAvailableCell {
            return
        }
        
        delegate?.moveToNote(note: notesTableVM.getNote(at: indexPath.row))
    }


}

extension NotesTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text  else { return }
        delegate?.searchNotesWithText(searchText: searchBarText, completion: {[weak self] (notes) in
            self?.notesTableVM.setNotes(notes: notes)
            self?.tableView.reloadData()
        })
        
        print(searchBarText)
    }
    
    
}
