//
//  RepositoryViewController.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 10..
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerProfileTextView: UITextView!
    @IBOutlet weak var repositoryLinkTextView: UITextView!
    @IBOutlet weak var repositoryDescriptionTextView: UITextView!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    
    
    var repoName : String?
    var repoDescription : String?
    var stars : Int?
    var update : String?
    var ownerName : String?
    var ownerAvatar : String?
    var ownerProfile : String?
    var repoLink : String?
    var forkNumber : Int?
    var createdAt : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = repoName{
            repositoryName.text = name
        }
        if let description = repoDescription{
            repositoryDescriptionTextView.text = description
        }
        if let score = stars{
            starsLabel.text = String(score)
        }
        if let lastUpdate = update{
            lastUpdateLabel.text = dateFormatter(date: lastUpdate)
        }
        if let oName = ownerName{
            ownerNameLabel.text = oName
        }
        if let avatar = ownerAvatar{
            let avatarURL = URL(string: avatar)!
            downloadImage(from: avatarURL)
        }
        if let oProflie = ownerProfile{
            ownerProfileTextView.text = oProflie
        }
        if let link = repoLink{
            repositoryLinkTextView.text = link
        }
        if let forks = forkNumber{
            forksLabel.text = String(forks)
        }
        if let created = createdAt{
            createdAtLabel.text = dateFormatter(date: created)
            
        }
        
    }
    
    //MARK: Functions
    func dateFormatter(date : String) -> String{
        let dateFormatter = ISO8601DateFormatter()
        let formattedDate = dateFormatter.date(from:date)!
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let newDate = df.string(from: formattedDate)
        return newDate
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.avatarImageView.image = UIImage(data: data)
            }
        }
    }

}


