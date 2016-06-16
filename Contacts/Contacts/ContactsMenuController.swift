//
//  ContactsMenuController.swift
//  Contacts
//
//  Created by Kevin Zeckser on 6/13/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import UIKit

class ContactsMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    // MARK: - Properties & Outlets
    
    private var contacts = [Contact]()
    private var filteredContacts = [Contact]()
    private let reuseIdentifier = "Cell"
    private let cellNib = "ContactViewCell"
    private let contactIndex = (65...90).map({String(Character(UnicodeScalar($0)))})
    private var tempContactDictionary : [String:[Contact]] = [:]
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        tableView.registerNib(UINib(nibName: cellNib, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        contacts = [Contact(name: "Amy", phoneNumber: "1234567890"),
                    Contact(name: "Bonnie", phoneNumber: "5456796231"),
                    Contact(name: "Carl", phoneNumber: "1234567890"),
                    Contact(name: "Dean", phoneNumber: "1234567890"),
                    Contact(name: "Eric", phoneNumber: "1234567890"),
                    Contact(name: "Frank", phoneNumber: "1234567890"),
                    Contact(name: "Greg", phoneNumber: "1234567890"),
                    Contact(name: "Harry", phoneNumber: "1234567890"),
                    Contact(name: "Ian", phoneNumber: "1234567890"),
                    Contact(name: "Jack", phoneNumber: "1234567890"),
                    Contact(name: "Kevin", phoneNumber: "1234567890"),
                    Contact(name: "Lia", phoneNumber: "1234567890"),
                    Contact(name: "Mark", phoneNumber: "1234567890"),
                    Contact(name: "Nick", phoneNumber: "1234567890"),
                    Contact(name: "Olly", phoneNumber: "1234567890"),
                    Contact(name: "Peter", phoneNumber: "1234567890"),
                    Contact(name: "Qian", phoneNumber: "1234567890"),
                    Contact(name: "Ryan", phoneNumber: "1234567890"),
                    Contact(name: "Sam", phoneNumber: "1234567890"),
                    Contact(name: "Timothy", phoneNumber: "1234567890"),
                    Contact(name: "Uma", phoneNumber: "1234567890"),
                    Contact(name: "Veronica", phoneNumber: "1234567890"),
                    Contact(name: "WALL-E", phoneNumber: "1234567890"),
                    Contact(name: "Xia", phoneNumber: "1234567890"),
                    Contact(name: "Yan", phoneNumber: "1234567890"),
                    Contact(name: "Zack", phoneNumber: "1234567890")
        ]
        setupDictionary()
        filterContacts(contacts)
    }
    
    // MARK: - ConvertPhoneNumber
    
    func formatPhoneNumber(phoneNumber: String) -> String {
        let input = NSMutableString(string: phoneNumber)
        input.insertString("(", atIndex: 0)
        input.insertString(")", atIndex: 4)
        input.insertString("-", atIndex: 5)
        input.insertString("-", atIndex: 9)
        return String(input)
    }
    
    // MARK: - Filter Contacts
    
    func setupDictionary() {
        for key in contactIndex {
            tempContactDictionary[key] = []
        }
    }
    
    func filterContacts(contacts: [Contact]) {
        for contact in contacts {
            insertContactInDictionary(contact)
        }
    }
    
    func insertContactInDictionary(contact: Contact) {
        for key in contactIndex {
            let contactKey = String(contact.name[contact.name.startIndex])
            if key == contactKey {
                tempContactDictionary[key]?.append(contact)
                break
            }
        }
    }

    // MARK: - SearchController Protocol & Helper method
    
    func filterContentForSearchText(searchText: String) {
        filteredContacts = contacts.filter { contact in
            return contact.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - TableViewDataSource
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return 1
        }
        return contactIndex.count
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = contactIndex[section]
        if searchController.active && searchController.searchBar.text != "" {
            return filteredContacts.count
        }
        guard let sectionContacts = tempContactDictionary[sectionTitle] else { return 1 }
        return sectionContacts.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ContactViewCell
        var contact: Contact?
        
        if searchController.active && searchController.searchBar.text != "" {
            contact = filteredContacts[indexPath.row]
        } else {
            let sectionTitle = contactIndex[indexPath.section]
            if let sectionContacts = tempContactDictionary[sectionTitle] {
                contact = sectionContacts[indexPath.row]
            }
        }
        
        cell.contactName?.text = contact?.name
        cell.contactPhoneNumber?.text = formatPhoneNumber((contact?.phoneNumber)!)
        
        return cell
    }
    
    internal func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return contactIndex
    }
    
    internal func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return contactIndex.indexOf(title)!
    }
    
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.active && searchController.searchBar.text != "" {
            return nil
        }
        return contactIndex[section]
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = contacts[indexPath.row]
        callNumber(contact.phoneNumber)
    }
    
    // MARK: - MakePhoneCall
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = NSURL(string: "tel://\(phoneNumber)") {
            let application = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
}
