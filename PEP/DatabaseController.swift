//
//  DatabaseController.swift
//  PEP
//
//  Created by Corina Nibbering on 29-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseController {
    
    var database = try! Realm()
    
    static let sharedControl = DatabaseController()
    
    func dataRealm(){
        self.database = try! Realm()
    }
    
    func saveFigure(fig: Figure){
        dataRealm()
        try! database.write({
            database.add(fig)
        })
    }
    
    
    func saveFigureRule(rule: FigureRules){
        dataRealm()
        try! database.write({
            database.add(rule)
        })
    }
    
    func savePassColor(color: PassportColor){
        dataRealm()
        try! database.write({
            database.add(color)
        })
    }
    
    func deleteAll(){
        dataRealm()

        try! database.write({
            database.deleteAll()
        })
    }
    
    func savePassport(pass: Passport){
        dataRealm()
        try! database.write({
            database.add(pass)
        })
    }
    
    func addColorToPassport( color: PassportColor){
        dataRealm()
        let pass = getPassport()
        try! database.write({
            pass.season.append(color)
            database.add(pass, update: true)
        })
    }
    
    func addRuleToFigure( rule: FigureRules){
        dataRealm()
        let pass = getPassport()
        try! database.write({
            pass.figure!.figureRules.append(rule)
            database.add(pass, update: true)
        })
    }
    
    func getPassport() -> Passport{
        dataRealm()
        let pass = database.objects(Passport).filter("user_id = 0").first
        return pass!
    }
    
    
}