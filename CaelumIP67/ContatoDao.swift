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
        contatos = Array()
        super.init()
    }
    
    func listaTodos() -> [Contato] {
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao: Int) -> Contato {
        return contatos[posicao]
    }
    func remove(_ posicao:Int){
    contatos.remove(at: posicao)
    }
    func buscaPosicaoDoContato(_ contato:Contato) -> Int {
    return contatos.index(of: contato)!
    }
}
