//
//  ViewController.swift
//  Meanings Viewcontroller
//
//  Created by 1964058 on 02/06/22.
//

import UIKit

class ViewController: UIViewController,Loadable {
   
    @IBOutlet weak var meaningTableView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    var viewModel: MeaningsViewModel!
    var searchResults:[MeaningCellViewModel]?
    
    func initViewModel(viewModel:MeaningsViewModel = MeaningsViewModel()){
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        searchBar.searchTextField.clearButtonMode = .never
        meaningTableView.estimatedRowHeight = 44
        meaningTableView.delegate = self
        initViewModel()
    }
    
    func clearList() {
        self.searchResults = []
        self.meaningTableView.reloadData()
    }
    
}

// MARK: - Tableview Datasource

extension ViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if let model = self.searchResults, model.isEmpty {
            let noDataLabel: UILabel  = UILabel()
            tableView.backgroundView  = noDataLabel
            noDataLabel.translatesAutoresizingMaskIntoConstraints = false
            noDataLabel.widthAnchor.constraint(equalToConstant: meaningTableView.bounds.width).isActive = true
            noDataLabel.heightAnchor.constraint(equalToConstant: meaningTableView.bounds.height).isActive = true
            noDataLabel.centerXAnchor.constraint(equalTo: meaningTableView.centerXAnchor).isActive = true
            noDataLabel.centerYAnchor.constraint(equalTo: meaningTableView.centerYAnchor).isActive = true
            
            noDataLabel.text          = "No meanings available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.separatorStyle  = .none
        } else {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.searchResults else {
            return 0
        }
                  
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meaningCell", for: indexPath) as! MeaningTableViewCell
        let cellModel = self.searchResults?[indexPath.row]
        cell.cellViewModel = cellModel
        return cell
    }
}

//MARK: Tableview Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
}


//MARK: - Searchbar Delegate

extension ViewController:UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.clearList()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.showAlert(with: "Please enter any text")
            self.clearList()
            return
        }
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard viewModel.checkSearchTextLength(searchText: searchText) else {
            return
        }
        showLoadingView()
        viewModel.fetchMeaning(with: searchText) { [weak self] status, errorMessage, responseList in
            DispatchQueue.main.async {
                self?.hideLoadingView()
                if !status {
                    if let error = errorMessage {
                        self?.showAlert(with: error)
                    }
                }
                if let responseList = responseList {
                    self?.searchResults = responseList
                }
                self?.meaningTableView.reloadData()
            }
        }
    }
}

//MARK: Alert View

extension ViewController {
    
    func showAlert(with message:String) {
        let alert = UIAlertController(title: "Meanings", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
    
