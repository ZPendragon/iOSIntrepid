//
//  SASearchViewController.swift
//  SpotifyArtistsViewer
//
//  Created by Kevin Zeckser on 6/6/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import UIKit

class SASearchViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchSegmentControl: UISegmentedControl!
    
    private var artists = [SAArtist]()
    private let requestManager = SARequestManager.sharedInstance
    let cellType = "UITableViewCell?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .blackColor()
        view.backgroundColor = .blackColor()
        textField.textColor = .whiteColor()
    }
    // MARK: - SARequestManager Callback
    
    private func updateFilteredArtistsWithResult(result: SAResponse) {
        switch result {
        case .Failure(let error):
            print("Error fetching artists: \(error)")
        case .Success(let returnedArtists):
            print("Success!!!")
            artists = returnedArtists
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count
    }
    
    override internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.artists[indexPath.row].name
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    @objc internal func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let searchQuery = self.textField.text else { return true }
        requestManager.getArtistsWithQuery(searchQuery, completion: updateFilteredArtistsWithResult)
        
        if !artists.isEmpty {
            self.artists.removeAll()
        }
        
        return true
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let destinationController = segue.destinationViewController as? SAArtistViewController {
                destinationController.detailArtist = self.artists[indexPath.row]
                destinationController.navigationItem.title = artists[indexPath.row].name
            }
        }
    }
}
