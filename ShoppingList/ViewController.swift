//
//  ViewController.swift
//  ShoppingList
//
//  Created by Usuário Convidado on 25/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfName: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { (result, error) in
            if error == nil{
                print("Conta criada!")
                self.upDateUserAndProceed()
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { (result, error) in
            if error == nil{
                print("Conta criada com sucesso")
            }
        }
        
    }
    
    func upDateUserAndProceed(){
        if tfName.text!.isEmpty {
            showMainScreen()
        }else{
            guard let user = Auth.auth().currentUser else{return}
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = tfName.text!
            changeRequest.commitChanges { (error) in
                if error == nil {
                    print("Nome alterados com sucesso")
                }
                self.showMainScreen()
            }
        }
        
    }
    
    func showMainScreen(){
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "TableViewController") else{return}
        navigationController?.viewControllers = [mainVC]
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

