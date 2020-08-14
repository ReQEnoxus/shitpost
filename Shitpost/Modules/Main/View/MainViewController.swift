//
//  MainViewController.swift
//  Shitpost
//
//  Created by Enoxus on 12.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import SwipeMenuViewController
import Firebase

class MainViewController: SwipeMenuViewController {
    
    let titles = [Text.Post.viewControllerName, Text.User.viewControllerName]
    
    var router: MainRouterInput!
    var interactor: MainInteractorInput!
    
    override func viewDidLoad() {
        
        self.addChild(PostsAssembly.configure())
        self.addChild(UINavigationController(rootViewController: UIViewController()))
        
        super.viewDidLoad()
        
        setupNavigationBar()
        
        view.backgroundColor = .white
        
        var options = SwipeMenuViewOptions()
        options.tabView.addition = .underline
        options.tabView.itemView.width = view.frame.width / CGFloat(titles.count)
        options.tabView.style = .segmented
        options.tabView.additionView.backgroundColor = .systemRed
        options.tabView.itemView.selectedTextColor = .systemRed
    
        swipeMenuView.reloadData(options: options, default: nil, isOrientationChange: false)
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Text.Post.exitButtonTitle, style: .plain, target: self, action: #selector(didTapExitButton))
        navigationItem.backBarButtonItem = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc fileprivate func didTapExitButton() {
        interactor.logOut()
    }
    
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return titles.count
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return titles[index]
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = self.children[index]
        vc.didMove(toParent: self)
        return vc
    }
}

extension MainViewController: MainViewInput {
    func signOffFinished() {
        router.exit()
    }
}
