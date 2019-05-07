//
//  Game+CoreDataProperties.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/7/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var gameDate: NSDate?
    @NSManaged public var score: Int16

}
