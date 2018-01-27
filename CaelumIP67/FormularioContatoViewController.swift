// Author: Phelipe Lopes
//  ViewController.swift
//  CaelumIP67
//
//  Created by ios7289 on 1/6/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit
import CoreLocation
class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var siteText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
   
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
            self.longitude.text = contato.longitude?.description
            self.latitude.text = contato.latitude?.description
            
            if let foto = contato.foto {
            self.imageView.image = self.contato.foto
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
            self.contato = dao.novoContato()
        }
        
        contato.nome = nome.text!
        contato.telefone = telefone.text!
        contato.endereco = endereco.text!
        contato.site = siteText.text!
        contato.foto = imageView.image
        
        if let latitude = Double(self.latitude.text!){
            self.contato.latitude = latitude as NSNumber
        }
        if let longitude = Double(self.longitude.text!){
            self.contato.longitude = longitude as NSNumber
        }
        
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
    private func pegarImage(da sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func selecionaFoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "Escolha foto do contato", message: self.contato.nome, preferredStyle: .actionSheet)
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            let tirarFoto = UIAlertAction(title: "Tirar Foto", style: .default){(action) in
                self.pegarImage(da: .camera)
            
            }
            let escolherFoto = UIAlertAction(title: "Escolher da biblioteca", style: .default){(action) in          self.pegarImage(da: .photoLibrary)
            
            }
            alert.addAction(cancelar)
            alert.addAction(tirarFoto)
            alert.addAction(escolherFoto)
            
            self.present(alert, animated: true, completion: nil)
            
        }else{
            pegarImage(da: .photoLibrary)
    
            
//        }else{
//        
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.allowsEditing = true
//            imagePicker.delegate = self
//            
//            
//            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func buscarCoordenadas(_ sender: UIButton) {
        
        if endereco.text! == "" {
            
            latitude.text  = ""
            longitude.text = ""
            
         let alerta = UIAlertController(title: "Erro de consistência", message: "Para calcular a localização, é necessário preeencher o endereço", preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alerta.addAction(cancelar)
            self.present(alerta, animated: true, completion: nil)
            
            
            return
        }
            
        self.loading.startAnimating()
        sender.isEnabled = false
        let geocoder = CLGeocoder()
        
            geocoder.geocodeAddressString(self.endereco.text!) { (resultado, error) in
            if error == nil && (resultado?.count)! > 0 {
                let placework = resultado![0]
                let coordenada = placework.location!.coordinate
                
                self.latitude.text = coordenada.latitude.description
                self.longitude.text = coordenada.longitude.description
            }
                self.loading.stopAnimating()
                sender.isEnabled = true
            
        }
    }

}

