//
//  Dishes.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import Foundation

struct Dishes : Codable{
  let name: String
  let description: String
  let weight: String
  let cost: String
  let imgURL: String
  
  init(name: String, description: String, weight: String, cost: String, imgURL: String){
    self.name = name
    self.description = description
    self.weight = weight
    self.cost = cost
    self.imgURL = imgURL
  }
  
}
