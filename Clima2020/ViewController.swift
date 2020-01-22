//
//  ViewController.swift
//  Clima2020
//
//  Created by IPaco on 22/01/2020.
//  Copyright © 2020 IPaco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var ivIcoCurrent: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPronoCurrent: UILabel!
    @IBOutlet weak var lblTempCuerrent: UILabel!
    @IBOutlet weak var lblPPCurrent: UILabel!
    
    var parser = XMLParser()        // Parseador
    var dias = [[String:String]]()      // Array de diccionario dias
    var dia = [String:String]()     // Diccionario dia
    var nodo = ""
    var currentIco:String = ""
    var currentPro = String()
    var currentTem = String()
    var currentPre = String()
    var isWeather : Bool = false
    var isCurrent : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let  urlTxt="http://api.worldweatheronline.com/premium/v1/weather.ashx?key=d31d55472f974dacb06200547202101&q=Toledo,Spain&num_of_days=10&fx24=yes&lang=es&mca=no&tp=24&format=xml"
        let url = URL(string: urlTxt)
        parser = XMLParser(contentsOf:(url)!)!
        parser.delegate = self
        parser.parse()
        pintaCurrent()
    }
    
    // Metodos del Parser
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "current_condition" {
            isCurrent = true
        }else if elementName == "weather" {
            isWeather = true
            dia = [String:String]()
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "current_condition" {
            isCurrent = false
        }else if elementName == "weather" {
            isWeather = false
            dias.append(dia)
        }else if isCurrent && elementName == "weatherIconUrl" {
            currentIco = nodo
        }else if isCurrent && elementName == "weatherDesc" {
            currentPro = nodo
        }else if isCurrent && elementName == "temp_C" {
            currentTem = nodo
        }else if isCurrent && elementName == "precipMM" {
            currentPre = nodo
        }else if isWeather && elementName == "weatherIconUrl" {
            dia["ico"] = nodo
        }else if isWeather && elementName == "weatherDesc" {
            dia["prono"] = nodo
        }else if isWeather && elementName == "mintempC" {
            dia["min"] = nodo
        }else if isWeather && elementName == "maxtempC" {
            dia["max"] = nodo
        }else if isWeather && elementName == "precipMM" {
            dia["pre"] = nodo
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        nodo = string
    }
    
    // Metodos del TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! MiCelda
        let dia = dias[indexPath.row]
        // ico
        let url = URL(string: dia["ico"]!)
        let data = try? Data(contentsOf: url!)
        celda.ivIcoCalda.image = UIImage(data: data!)
        // resto
        celda.lblPronoCelda.text = dia["prono"]
        celda.lblMaxCelda.text = "\(dia["max"]!)º"
        celda.lblMinCelda.text = "\(dia["min"]!)º"
        celda.lblPreCelda.text = "\(dia["pre"]!)%"
        
        return celda
    }
    
    // Vistas
    
    func pintaCurrent(){
        let url = URL(string: currentIco)
        let data = try? Data(contentsOf: url!)
        ivIcoCurrent.image = UIImage(data: data!)
        lblPronoCurrent.text = currentPro
        lblTempCuerrent.text = "\(currentTem)º"
        lblPPCurrent.text = "\(currentPre)%"
    }
}

