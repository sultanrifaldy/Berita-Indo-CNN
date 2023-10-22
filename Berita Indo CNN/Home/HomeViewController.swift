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
    
    var categories: [String] = ["Politik", "Olahraga", "Internasional", "Kuliner"]
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell", for: indexPath) as! HomeViewCell
        
        let news = latestNews[indexPath.row]
        cell.titleLabel.text = news.title
        cell.authorLabel.text = "Jurnalis"
        cell.dateLabel.text = news.isoDate
        cell.thumbImageView.sd_setImage(with: URL(string: news.image.small))
        
        return cell
    }
    
    
}
