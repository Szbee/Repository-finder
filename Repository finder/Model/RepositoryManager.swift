//
//  RepositoryManager.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 07..
//

import Foundation

protocol RepositoryManagerDelegate {
    func didUpdate(_ repositoryManager : RepositoryManager, repositoryArray : [RepositoryListModel])
    func didFailedWithError(error : Error)
}

struct RepositoryManager {
    var delegate : RepositoryManagerDelegate?
    
    func fetchURL(key: String){
        let apiURL = "https://api.github.com/search/repositories?q=\(key)"
        
        performRequest(with: apiURL)
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data {

                    if let repository = self.parseJSON(safeData){
                        DispatchQueue.main.async {
                            self.delegate?.didUpdate(self, repositoryArray: repository)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ repositoryData: Data)-> [RepositoryListModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RepositoryData.self, from: repositoryData)
            
            var repoArray : [RepositoryListModel] = []
            
            
            for i in 0..<(decodedData.items.count) {
                let  repositoryName = decodedData.items[i].name
                let repositoryDescription = decodedData.items[i].description
                let stars = decodedData.items[i].stargazers_count
                let lastUpdate = decodedData.items[i].updated_at
                
                let ownerName = decodedData.items[i].owner.login
                let ownerAvatar = decodedData.items[i].owner.avatar_url
                let ownerProfile = decodedData.items[i].owner.html_url
                let repoLink = decodedData.items[i].html_url
                let forkNumber = decodedData.items[i].forks_count
                let createdAt = decodedData.items[i].created_at

                let repoList = RepositoryListModel(repoName: repositoryName ?? "", repoDescription: repositoryDescription ?? "", stars: stars ?? 0, update: lastUpdate ?? "", ownerName: ownerName ?? "", ownerAvatar: ownerAvatar ?? "", ownerProfile: ownerProfile ?? "", repoLink: repoLink ?? "", forkNumber: forkNumber ?? 0, createdAt: createdAt ?? "")
                repoArray.append(repoList)
                
            }
            
            return repoArray
        } catch  {
            print(error)
            return []
        }
    }
    
}
