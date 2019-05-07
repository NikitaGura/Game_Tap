//
//  ResultCollectionViewFlowLayout.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/6/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class ResultCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        guard let cv = collectionView else {return}
        itemSize = CGSize(width: cv.bounds.inset(by: cv.layoutMargins).size.width, height: cv.bounds.inset(by: cv.layoutMargins).size.height / 6.5)
        sectionInset = UIEdgeInsets(top: minimumInteritemSpacing, left: 0, bottom: 0, right: 0)
        sectionInsetReference = .fromSafeArea
    }
}
