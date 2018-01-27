//
//  ContatosNoMapaViewController.swift
//  CaelumIP67
//
//  Created by ios7126 on 20/01/18.
//  Copyright © 2018 Caelum. All rights reserved.
//

import UIKit
import MapKit


class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapa: MKMapView!
    var contatos: [Contato] = Array()
    let locationManager = CLLocationManager()
    let dao: ContatoDao = ContatoDao.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mapa"
        
        
        
        self.mapa.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.contatos = dao.listaTodos()
        self.mapa.addAnnotations(self.contatos)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(self.contatos)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
        
        return nil
        }
        let identifier: String = "pino"
    
        var pino : MKPinAnnotationView
        
        if let reusablePin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
        pino = reusablePin
        }else{
        pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contato = annotation as? Contato {
        
            pino.pinTintColor = UIColor.red
            pino.canShowCallout = true
            
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let imagemContato = UIImageView(frame: frame)
            
            imagemContato.image = contato.foto
            
            pino.leftCalloutAccessoryView = imagemContato
        }
        
        return pino
        
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let pinToZoom = view.annotation
//        
//        let span = MKCoordinateSpanMake(0.5, 0.5)
//        
//        let region = MKCoordinateRegion(center: pinToZoom!.coordinate, span: span)
//        
//        mapView.setRegion(region, animated: true)
//    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pinToZoom = view.annotation
        
        mapView.showAnnotations([pinToZoom!], animated: true)
        
        mapView.selectAnnotation(pinToZoom!, animated: true)
    }

}
