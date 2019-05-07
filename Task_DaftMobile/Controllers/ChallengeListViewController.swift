//
//  ChallengeListViewController.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/6/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit
import CoreData

class ChallengeListViewController: UIViewController {
    
    //MARK: variables
    private let cellId = "cellId"
    private var arrGame = [Game]()
    private let fethRequestGames: NSFetchRequest<Game> = Game.fetchRequest()
    
    private let reusltsCollection: UICollectionView = {
        let layout = ResultCollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    private lazy var buttonPlay = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupresultsCollection()
        setupButtonPlay()
        view.addSubview(reusltsCollection)
        view.addSubview(buttonPlay)
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        do{
            let games = try PersistenceSerivce.shared.context.fetch(fethRequestGames)
            self.arrGame = games
        } catch {}
        
        arrGame.sort(by: { $0.score > $1.score })
        
        if(arrGame.count > 5){
            arrGame.suffix(from: 5).forEach {
                PersistenceSerivce.shared.context.delete($0)
            }
            for _ in 6...arrGame.count{
                arrGame.removeLast()
            }
        }
        PersistenceSerivce.shared.saveContext()
    }
    
    
    
    //MARK: Methods
    private func setupresultsCollection(){
        reusltsCollection.dataSource = self
        reusltsCollection.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupButtonPlay(){
        buttonPlay.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        buttonPlay.setTitle("Play", for: [])
        buttonPlay.addTarget(self, action: #selector(play), for: .touchUpInside)
    }
    
    private func setupLayout(){
        reusltsCollection.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reusltsCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reusltsCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reusltsCollection.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            reusltsCollection.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            buttonPlay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonPlay.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    //MARK: Selectors
    
    @objc func play(){
        present(FirstViewController(), animated: true, completion: nil)
    }
}


// MARK: DataSource collection
extension ChallengeListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 > arrGame.count ? arrGame.count : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reusltsCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultCollectionViewCell
        cell.backgroundColor  = .gray
        cell.layer.cornerRadius = 8.0
        cell.game = arrGame[indexPath.row]
        return cell
    }
    
}
