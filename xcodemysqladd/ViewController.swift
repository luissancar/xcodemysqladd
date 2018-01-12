//
//  ViewController.swift
//  xcodemysqladd
//
//  Created by Luis José Sánchez Carrasco on 3/1/18.
//  Copyright © 2018 Luis José Sánchez Carrasco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var codText: UITextField!
    @IBOutlet weak var cosaText: UITextField!
   
    var  message : String = "" 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addButton(_ sender: Any) {
        
        
        //put the link of the php file here. The php file connects the mysql and swift
        let request = NSMutableURLRequest(url: NSURL(string: "http://iesayala.ddns.net/xcode/add.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "a=\(codText.text!)&b=\(cosaText.text!)"
        
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                self.message = "Error 1"
                return
            }
            
            print("response = \(response)")
            
            
            // resultado (valor del echo de php)
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            if ((responseString?.isEqual(to: "1")))! {
                self.message = "Añadido"
                
            }
            else {
                self.message = "Error al añadir"
                
            }
            
            print("responseString = \(responseString)")
        }
        task.resume()
        let alert = UIAlertController(title: "Registro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        print("ffff \(self.message)")
        
        
        
        
        
        
        codText.text = ""
        cosaText.text = ""
        codText.becomeFirstResponder()  // pasar foco
    }
    
    
    
        
    
}

