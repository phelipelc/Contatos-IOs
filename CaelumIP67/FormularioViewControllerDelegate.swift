//
//  FormularioViewControllerDelegate.swift
//  CaelumIP67
//
//  Created by ios7126 on 13/01/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

protocol FormularioViewControllerDelegate {
    
    
    func contatoAtualizado(_ contato: Contato)
    func contatoAdicionado(_ contato: Contato)
}
