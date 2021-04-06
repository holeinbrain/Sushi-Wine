//
//  Extention.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import UIKit

// MARK: - Search Bar
extension MainViewController: UISearchResultsUpdating {
  func searchSetup() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Найди что нужно =)"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
  // Filters dishes based on search text
  func filterContentForSearchText(_ searchText: String) {
    filteredDishes = dishes.filter { (named : Dishes) -> Bool in
      return named.name.lowercased().contains(searchText.lowercased())
    }
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

// MARK: - TableView
extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
    return filteredDishes.count
    } else {
    return dishes.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell") as? DishesCell else {
      return UITableViewCell() }
    var dishFiltUnfilt = dishes
    if isFiltering {
      dishFiltUnfilt = filteredDishes
    } else {
      dishFiltUnfilt = dishes
    }
    cell.dishName.text = dishFiltUnfilt[indexPath.row].name
    cell.dishWeight.text = "Вес: " + dishFiltUnfilt[indexPath.row].weight + " грамм"
    cell.dishPrice.text = "Цена: " + dishFiltUnfilt[indexPath.row].cost + " грн."
    cell.dishDescription.text = dishFiltUnfilt[indexPath.row].description
    if let imageUrl = URL(string: dishFiltUnfilt[indexPath.row].imgURL) {
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: imageUrl)
        if let data = data {
          let image = UIImage(data: data)
          DispatchQueue.main.async {
            cell.dishImage.image = image
          }
        }
      }
    }
    return cell
  }
}

