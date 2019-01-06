//
//  ViewController.swift
//  Weather
//
//  Created by Musa Mohannad on 2019-01-05.
//  Copyright © 2019 Musa Mohannad. All rights reserved.
//

import UIKit

class Weather: UIViewController {
    
    var txt=""

    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Text.text="Weather in houston is:"
        getweather()

    }

   
    
    @IBAction func showweather(_ sender: UIButton) {
        getweather()
        
    }
    
    func getweather(){
    let session = URLSession.shared
       let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Houston,us?&units=imperial&APPID=524f5bed27b2fee5b488c047beef0530")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else
            {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.Text.text = "Houston Temperature: \(temperature)°F"
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
}
}

