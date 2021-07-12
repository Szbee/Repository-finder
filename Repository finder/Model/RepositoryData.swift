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
    let name : String? //repo név
    let description : String? //repo leírás
    let score : Double? //csillagok
    let stargazers_count : Int? //csillagok száma
    let updated_at : String? //frissítés
    
    let owner : Owner
    let html_url : String? //repo url
    let forks_count : Int? //forkok száma
    let created_at  : String? //létrehozás dátuma
}

struct Owner : Decodable {
    let login : String? //owner neve
    let avatar_url : String? //avatar képe
    let html_url : String? //github profil link
}
