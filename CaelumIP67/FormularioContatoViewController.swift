// Author: Phelipe Lopes
//  ViewController.swift
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var siteText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
   
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
            
            if let foto = self.contato.foto {
            imageView.image = contato.foto
            }
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self,
                                               action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
            
        }
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender: )))
        
        self.imageView.addGestureRecognizer(tap)

        
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
        contato.foto = imageView.image
        
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
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = imagemSelecionada
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func selecionaFoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
        }else{
        
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

}

