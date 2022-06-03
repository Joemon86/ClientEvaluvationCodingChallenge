//
//  MeaningsViewModel.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

fileprivate var baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="

typealias CompletionHandler = (_ status:Bool, _ errorMessage:String?) -> Void

class MeaningsViewModel:NSObject {
    
    var apiManager = APIManager()
    
    var maeningCellViewModel: [MeaningCellViewModel]?
    
    func fetchMeaning(with text:String, completion: @escaping (CompletionHandler)) {
        guard !text.isEmpty, let url = URL(string:baseURL + text) else {
            completion(false, "Data Error")
            return
        }
        apiManager.loadData(from: url) { result in
            switch result {
            case .data(let data):
                do {
                    var meanings = [MeaningCellViewModel]()
                    let meaning:[Meaning] = try JSONDecoder().decode([Meaning].self, from: data)
                    if meaning.isEmpty {
                        print("Empty Data")
                        self.maeningCellViewModel = meanings
                        completion(false,"Empty Data")
                        return
                    } else {
                        var lfs:[lfs] = []
                        if let first = meaning.first, let meanings = first.lfs {
                            lfs = meanings
                        }
                        for item in lfs {
                            meanings.append(MeaningCellViewModel(meaningText: item.lf))
                        }
                        self.maeningCellViewModel = meanings
                        completion(true,nil)
                        return
                    }
                } catch let parseError {
                    print(parseError.localizedDescription)
                    completion(false,parseError.localizedDescription)
                    return
                }
            case .error(let error):
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
                return
            }
        }
    }
    
    func getMeaningCellModel(indexpath: IndexPath) -> MeaningCellViewModel? {
        guard let model = maeningCellViewModel else {
            return nil
        }
        return model[indexpath.row]
    }
    
    func clearData(){
        self.maeningCellViewModel = []
    }
}
