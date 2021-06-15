//
//  Feed.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation

// MARK: - Feed
class Feed: Codable {
    var tiles = [Tile]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let body = json["tiles"] as? [[String: Any]] {
                self.tiles = body.map { Tile(json: $0) }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
        
    }
}

// MARK: - Tile
class Tile: Codable {
    let name: FeedViewModelItemType
    let headline: String
    let subline: String?
    let data: String?
    let score: Int
    
    init(json: [String: Any]) {
        //print(json["name"])
        
        self.headline = json["headline"] as! String
        self.subline = json["subline"] as? String
        self.data = json["data"] as? String
        self.score = json["score"] as! Int
        let n = json["name"] as! String
        self.name = FeedViewModelItemType(rawValue: n)!
        
        
//        self.name = FeedViewModelItemType(rawValue: json["name"] as! String)!
    }
}
