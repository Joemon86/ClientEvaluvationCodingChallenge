//
//  ViewController.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import UIKit

class ViewController: UIViewController,Loadable {
   
    @IBOutlet weak var meaningTableView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    var viewModel: MeaningsViewModel!
    
    func initViewModel(viewModel:MeaningsViewModel = MeaningsViewModel()){
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        searchBar.searchTextField.clearButtonMode = .never
        meaningTableView.rowHeight = 44
        meaningTableView.delegate = self
        initViewModel()
    }
}

extension ViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if viewModel.maeningCellViewModel?.isEmpty == false
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No meanings available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel.maeningCellViewModel else {
            return 0
        }
                  
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meaningCell", for: indexPath) as! MeaningTableViewCell
        let cellModel = viewModel.getMeaningCellModel(indexpath: indexPath)
        cell.cellViewModel = cellModel
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 44
        }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else {
            return
        }
        guard text.isEmpty != true else {
            self.showAlert(with: "Please enter any text")
            return
        }
        let searchText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        showLoadingView()
        viewModel.fetchMeaning(with: searchText) { [weak self] status, errorMessage in
            DispatchQueue.main.async {
                self?.hideLoadingView()
                if status == false {
                    if let error = errorMessage {
                        self?.showAlert(with: error)
                    }
                }
               
                self?.meaningTableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.clearData()
        self.meaningTableView.reloadData()
    }
}

extension ViewController {
    
    func showAlert(with message:String) {
        let alert = UIAlertController(title: "Meanings", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                fatalError()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
    
