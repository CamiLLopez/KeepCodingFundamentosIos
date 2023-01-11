//
//  LoginViewController.swift
//  Proyecto
//
//  Created by Camila Laura Lopez on 15/12/22.
//

import UIKit

class LoginViewController: UIViewController {

        
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Notificaciones con acciones de teclado

        NotificationCenter.default.addObserver(self, selector: #selector(openKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func openKeyBoard(){
        print("Abri el techaldo")
    }
    
    @objc func closeKeyBoard(){
        print("escondi el techaldo")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // no se pueden hacer cambios de UI porque la pantalla no esta cargada en memoria
        //llamadas API

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        //es la opacidad-visibilidad del boton
        loginButton.alpha = 0
        
        //volver a mostrarlos
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: []) {
            self.emailTextField.center.x += self.view.bounds.width
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1 ){
            self.loginButton.alpha = 1
        }
    }


    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Password uis empty")
            return
        }
        
        NetworkLayer.shared.login(email:email, password: password){
            token, error in
            if let token = token {
                LocalDataLayer.shared.save(token: token)
                print(token)
                
                DispatchQueue.main.async {
                    //Deprecated
                    //UIApplication.shared.keyWindow?.rootViewController = HomeTabBarController()
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap{($0 as? UIWindowScene)?.keyWindow}
                        .first?
                        .rootViewController = HomeTabBarController()

                }
                
                
            }else{
                print("Login Error", error?.localizedDescription ?? "")
            }
        }
    }

}
