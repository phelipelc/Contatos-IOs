// Author: Phelipe Lopes
//  ViewController.swift
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var siteText: UITextField!
   
    var delegate: FormularioContatoViewControllerDelegate?
    var dao: ContatoDao
    var contato: Contato!
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.siteText.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self,
                                               action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func pegarDadosDoFormulario() {
        if contato == nil {
            self.contato = Contato()
        }
        
        
        contato.nome = nome.text!
        contato.telefone = telefone.text!
        contato.endereco = endereco.text!
        contato.site = siteText.text!
        
    }
    
   @IBAction func criaContato(){
        self.pegarDadosDoFormulario()
        dao.adiciona(contato)
        //print(contato)
    self.delegate?.contatoAdicionado(contato)
   self.navigationController?.popViewController(animated: true)
    }
    func atualizaContato(){
    pegarDadosDoFormulario()
        self.delegate?.contatoAtualizado(contato)
        self.navigationController?.popViewController(animated: true)
    }
    

}

