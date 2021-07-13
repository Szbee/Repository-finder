//
//  RepositoryModel.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 07..
//

import Foundation

struct RepositoryData : Decodable{
    let items : [Items]
    
}

struct Items : Decodable {
    let name : String? 
    let description : String?
    let score : Double?
    let stargazers_count : Int?
    let updated_at : String?
    
    let owner : Owner
    let html_url : String?
    let forks_count : Int?
    let created_at  : String?
}

struct Owner : Decodable {
    let login : String?
    let avatar_url : String?
    let html_url : String?
}
