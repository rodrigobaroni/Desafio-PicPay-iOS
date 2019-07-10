//
//  ContactListViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

class ContactListViewController: CustomViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    @IBOutlet private(set) weak var tableView: UITableView?
    @IBOutlet private(set) weak var searchBar: CustomSearchBar?
    
    var contacts = [UserModel]()
    private var currentSearchContact = [UserModel]()
    var searchController: UISearchController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(with: "Contatos")
        self.callService()
        self.setupTableView()
        self.setupSearchBar()
    }
    
    private func setupTableView() {
        self.tableView?.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contactCell")
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
    }
    
    private func callService() {
        Service.users { [weak self] response in
            self?.contacts = response
            self?.currentSearchContact = response
            self?.tableView?.reloadData()
        }
    }
    
    private func setupSearchBar() {
        self.searchBar?.delegate = self
    }

}

extension ContactListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTextFiltered = searchText.removeSpecialCharacterIfFirst()
        guard !searchTextFiltered.isEmpty else {
            currentSearchContact = contacts
            self.tableView?.reloadData()
            return
        }
        currentSearchContact = contacts.filter { (contact) -> Bool in
            if let userName = contact.username,
                let name = contact.name {
                let canSearchByUserName = userName.removeSpecialCharacterIfFirst().contains(searchTextFiltered)
                if !canSearchByUserName {
                    return name.contains(searchTextFiltered)
                }
                return canSearchByUserName
            }
            return false
        }
        self.tableView?.reloadData()
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataStorage.retriveCardSaved { [weak self] card in
            if let cardData = card {
                self?.coordinator?.inputValue()
                return
            }
            self?.coordinator?.addNewCard()
        }
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSearchContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contacCell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as? ContactTableViewCell
        guard let cell = contacCell else {
            return UITableViewCell(frame: CGRect())
        }
        cell.contact = currentSearchContact[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
}


