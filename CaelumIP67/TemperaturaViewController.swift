 //
//  TemperaturaViewController.swift
//  CaelumIP67
//
//  Created by ios7126 on 03/02/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit

class TemperaturaViewController: UIViewController {
    @IBOutlet weak var CondicaoAtual: UILabel!
    @IBOutlet weak var TemperaturaMaxima: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TemperaturaMinima: UILabel!
    
    var contato: Contato?
    
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?appid=ccfa52e7060e254ab821e25c3765f691&units=metric"
    
    let URL_BASE_IMAGE = "http://api.openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contato = self.contato {
            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)") {
        
            let session = URLSession(configuration: .default)
                
                let task = session.dataTask(with: endpoint){(data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        
                        if httpResponse.statusCode == 200 {
                            
                            do{
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                                    
                                    let main = json["main"] as! [String:AnyObject]
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let temp_min = main["temp_min"] as! Double
                                    let temp_max = main["temp_max"] as! Double
                                    let icon = weather["icon"] as! String
                                    let condicao = weather["main"] as! String
                                
                                
                                    DispatchQueue.main.async {
                                        self.CondicaoAtual.text = condicao
                                        self.TemperaturaMinima.text = temp_min.description + "°"
                                        self.TemperaturaMaxima.text = temp_max.description + "°"
                                        self.pegaImagem(icon)
                                        
                                        self.CondicaoAtual.isHidden = false
                                        self.TemperaturaMinima.isHidden = false
                                        self.TemperaturaMaxima.isHidden = false
                                    }
                                    
                                }
                            }catch let erro as NSError {
                                print(erro.localizedDescription)
                            }
                        }
                     }
                
                }
                task.resume()
        }
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pegaImagem(_ icon:String){
        if let endpoint = URL(string: URL_BASE_IMAGE + icon + ".png") {
            print(endpoint)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: endpoint){(data, response, error)in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            print("Exibindo imagem")
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
                task.resume()
        }
    
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
