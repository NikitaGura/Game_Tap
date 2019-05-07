//
//  ResultCollectionViewCell.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/6/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    //MARK: Variables
    private lazy var labelResult = UILabel()
    private lazy var labelDate = UILabel()
    
    public var game: Game? {
        didSet{
            labelResult.text = "\(game?.score ?? 0)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d yyyy, hh:mm:ss"
            if let date = game?.gameDate{
                labelDate.text = dateFormatter.string(from: date as Date)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelResult()
        setupLabelDate()
        addSubview(labelResult)
        addSubview(labelDate)
        setupLayout()
    }
    
    
    //MARK: Methods

    private func setupLayout(){
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            labelDate.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelResult.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            labelResult.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupLabelResult(){
        labelResult.font = UIFont.boldSystemFont(ofSize: 16)
        labelResult.textAlignment = .left
    }
    
    private func setupLabelDate(){
        labelDate.font = UIFont.boldSystemFont(ofSize: 16)
        labelDate.textAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
