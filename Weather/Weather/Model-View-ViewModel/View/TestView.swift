//
//  TestView.swift
//  Weather
//
//  Created by Надежда Клименко on 31.10.21.
//

import UIKit
import NVActivityIndicatorView
import AVFoundation

class TestView: UIView {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var conteinerView: UIView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    var viewData: ViewData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var player: AVPlayer?
    let date = Date()
    let dateFormater = DateFormatter()
    var dayAfterTommorrow: Double = 0
    var weatherDataForFiveDays = WeatherDataForFiveDays()
    var dataSource: [TodayWeather] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle(for: TestView.self).loadNibNamed("TestView", owner: self, options: nil) //bundle дерево проекта. то есть в дереве проекта ищем наш класс и загружаем
        conteinerView.frame = self.bounds //инициализируем размер
        self.addSubview(conteinerView)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func updateView() {
        collectionView.layer.cornerRadius = 30
        switch viewData {
        case .initial:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let viewModel, let dataSourse):
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            let date = Date()
            RealmManager.shared.createRequest(viewModel: viewModel, date: date)
            update(viewModel: viewModel)
            self.dataSource = dataSourse
            setupCollectionView()
        case .failure:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            cityName.text = "City not found"
        }
    }
    
    private func update(viewModel: ViewModel) {
        cityName.text = viewModel.cityName
        descriptionLabel.text = viewModel.descriptionLabel
        temperature.text = viewModel.temperature
        feelLikesLabel.text = viewModel.feelLikesLabel
        weatherIcon.image = UIImage(named: viewModel.weatherIcon)
        windLabel.text = viewModel.windLabel
        dateLabel.text = viewModel.dateLabel
        timeLabel.text = viewModel.timeLabel
        playVideo(viewModel.pathVideo)
    }
    
    func playVideo(_ pathVideo: String?) {
        guard let pathVideo = pathVideo else { return }
        NotificationCenter.default.removeObserver(self)
        let urlVideo = URL(fileURLWithPath: pathVideo)
        let asset = AVAsset(url: urlVideo)
        let playItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playItem)
        self.player = player
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.frame = CGRect(origin: .zero, size: videoView.frame.size)
        videoLayer.videoGravity = .resizeAspectFill
        videoView.layer.insertSublayer(videoLayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playItem, queue: .main) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }
        player.play()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TodayWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodayWeatherCollectionViewCell")
    }
}

extension TestView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayWeatherCollectionViewCell", for: indexPath) as? TodayWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(with: dataSource[indexPath.item])
        
        return cell
    }
}

extension TestView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 130)
    }
}
