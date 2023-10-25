//
//  HomeViewController.swift
//  Berita Indo CNN
//
//  Created by Sultan Rifaldy on 22/10/23.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var latestNews: [News] = []
    
    let buttonLabels = ["Semua", "Politik", "Olahraga", "Internasional", "Kuliner", "Otomotif", "Selebriti"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        loadLatestNews()
        tableView.dataSource = self

    }
    
    func loadLatestNews() {
        ApiServices.shared.loadNews { result in
            switch result {
            case .success(let newsList):
                self.latestNews = newsList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return latestNews.count > 0 ? 1 : 0
        } else {
            return latestNews.count
        }
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categories_cell", for: indexPath) as! CategoriesViewCell
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell", for: indexPath) as! HomeViewCell
            
            let news = latestNews[indexPath.row]
            cell.titleLabel.text = news.title
            cell.authorLabel.text = "Jurnalis"
            cell.dateLabel.text = news.isoDate
            cell.thumbImageView.sd_setImage(with: URL(string: news.image.small))
            
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories_collection", for: indexPath) as! CategoriesCollectionViewCell
        
        cell.buttonCategories.setTitle(buttonLabels[indexPath.item], for: .normal)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Button \(buttonLabels[indexPath.item]) tapped")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

