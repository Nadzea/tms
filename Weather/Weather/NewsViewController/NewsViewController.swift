//
//  NewsViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 22.10.21.
//

import UIKit

enum TypeOfNews: Int {
    case newsOfRussia = 0
    case newsOfUSA = 1
    case aboutBitcoin = 2
}

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [[News_]] = [[]]
    
    var news = News()
    
    var news1 = News()

    var news2 = News() {
        didSet {
            DispatchQueue.main.sync {
                self.updateNews(news: news)
                self.updateNews(news: news1)
                self.updateNews(news: self.news2)
                self.setupTableView()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getNews()
    }
    
    func getNews() {
        HttpManager.shared.getNews(APIConstants.newsOfRussia.rawValue) { news in
            self.news = news
        }
        
        HttpManager.shared.getNews(APIConstants.newsOfUSA.rawValue) { news in
            self.news1 = news
        }
        
        HttpManager.shared.getNews(APIConstants.newsAboutBitcoin.rawValue) { news in
            self.news2 = news
        }
    }
    
    func updateNews(news: News) {
        var mass1: [News_] = []

        news.articles.forEach { someNews in
            let someNews = News_(title: someNews.title ?? "", url: someNews.url)
            mass1.append(someNews)
        }
    
        dataSource.append(mass1)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.tableFooterView = UIView()
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = TypeOfNews(rawValue: section) else { return 0 }
        
        switch section {
        
        case .newsOfRussia: return dataSource[1].count
        case .newsOfUSA: return dataSource[2].count
        case .aboutBitcoin: return dataSource[3].count
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = TypeOfNews(rawValue: section) else { return "" }
        
        switch section {
        case .newsOfRussia: return "Новости России"
        case .newsOfUSA: return "Top headlines in the US"
        case .aboutBitcoin: return "All articles about Bitcoin"
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell, let section = TypeOfNews(rawValue: indexPath.section)  else {
            return UITableViewCell()
        }
        
        switch section {
        case .newsOfRussia: cell.setData(with: dataSource[1][indexPath.row])
        case .newsOfUSA: cell.setData(with: dataSource[2][indexPath.row])
        case .aboutBitcoin: cell.setData(with: dataSource[3][indexPath.row])
        }
        
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //ячейка которая выбрана
        tableView.deselectRow(at: indexPath, animated: true) //анимационно подсвечивается серым потом этот фон исчезает
        
        print(indexPath.row)
        print(indexPath.section)
        print(dataSource[indexPath.section + 1][indexPath.row].url)
        
        let storyboard = UIStoryboard(name: "FullNewsViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? FullNewsViewController else { return }
        
        vc.url = dataSource[indexPath.section + 1][indexPath.row].url
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
