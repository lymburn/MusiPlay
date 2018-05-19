//
//  SearchController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-18.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SearchController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        searchBar.delegate = self
        
        //End editing when tapping outside search bar
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    override func setupViews() {
        super.setupMenuBar()
        view.addSubview(searchBar)
        setConstraints()
    }
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private func setConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

//MARK: UISearchBar delegates
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.setShowsCancelButton(true, animated: true)
        print("helLO")
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
