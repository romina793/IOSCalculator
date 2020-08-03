//
//  SceneDelegate.swift
//  IOS-Calculator
//
//  Created by Romina Pozzuto on 02/08/2020.
//  Copyright © 2020 Romina Pozzuto. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setUpView()
    }
    
    
    // MARK: Private Methos
    func setUpView()  {
        let vc = HomeViewController()
        self.makeKeyAndVisible(vc)
    }
    func makeKeyAndVisible(_ controller: UIViewController){
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }



}

