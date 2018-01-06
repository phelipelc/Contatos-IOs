//
//  ContatoDao.swift
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

class ContatoDao: NSObject {

    static private var defaultDAO: ContatoDao!
    var contatos : Array<Contato>
    
    func adiciona(_ contato: Contato){
    contatos.append(contato)
    }
    
    static func sharedInstance() -> ContatoDao{
        if defaultDAO == nil{
        defaultDAO = ContatoDao()
        }
            return defaultDAO
    }
            override private init(){
            self.contatos = Array()
            super.init()
            }
    
}
