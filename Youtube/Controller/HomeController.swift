//
//  ViewController.swift
//  Youtube
//
//  Created by 김진선 on 2017. 12. 19..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideo { (videos) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false
        setupTitleView()
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 50)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupTitleView() {
        let logoView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let logoImage = UIImageView(image: UIImage(named: "YouTube_logo"))
        logoImage.frame = CGRect(x: 8, y: 0, width: 100, height: logoView.frame.height)
        logoImage.contentMode = .scaleAspectFit
        logoImage.clipsToBounds = true
        
        logoView.addSubview(logoImage)
        
        navigationItem.titleView = logoView
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysTemplate)
        let searchBarBtnItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        searchBarBtnItem.tintColor = UIColor.darkGray
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysTemplate)
        let moreBtn = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        moreBtn.tintColor = UIColor.darkGray
        
        navigationItem.rightBarButtonItems = [moreBtn, searchBarBtnItem]
        
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.shadowRadius = 7
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        
        let videoCell = VideoCell()
        let seperateView = videoCell.separatorView
        seperateView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(seperateView)
        seperateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        seperateView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        seperateView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        seperateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    // lazy var instantiation the code that's inside of below block only gets called once if this variable is nil.
    
    lazy var settingsLauncher : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForeSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    @objc func handleSearch() {
        
    }
    
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        view.addSubview(menuBar)
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 88 + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

