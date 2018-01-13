//
//  FormularioViewControllerDelegateTableViewController.swift
//  CaelumIP67
//
//  Created by ios7126 on 13/01/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

protocol FormularioViewControllerDelegateTableViewController {
    func contatoAtualizado(_ contato: Contato)
    func contatoAdicionado(_contato: Contato)
}
