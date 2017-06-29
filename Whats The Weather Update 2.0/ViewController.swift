//
//  ViewController.swift
//  Whats The Weather Update 2.0
//
//  Created by Advait on 29/06/17.
//  Copyright © 2017 Advait. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = " "
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    @IBAction func buttonPressed(_ sender: Any) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q="+(myTextField.text?.replacingOccurrences(of: " ", with: "%20"))!+"&appid=c03a2c0aba62ffdc045b6fa1b0b2d252")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
            }
            else{
                if let userData = data {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: userData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult)
                        let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String
                        
                        DispatchQueue.main.sync(execute: {
                            self.resultLabel.text = description

                        })
                        
                    }
                    catch{
                        print("Failed to fetch json")
                        self.resultLabel.text = "Something went wrong"
                    }
                }
                else{
                    self.resultLabel.text = "Something went wrong"
                }
            }
            
        }
        task.resume()
        

    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

