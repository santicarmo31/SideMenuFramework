//
//  ViewController.swift
//  SideMenuExample
//
//  Created by Santiago Carmona Gonzalez on 5/20/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    // MARK: Vars & Constants
    internal lazy var sideMenu: SideMenuViewController = {
        guard let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController else {
            return SideMenuViewController()
        }
        menu.delegate = self
        menu.transitioningDelegate = self
        menu.swipeInteractionController = SideMenuSwipeInteractionController(viewController: self)
        return menu
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: IBActions
    @IBAction func showMenu(_ sender: Any) {
        present(sideMenu, animated: true, completion: nil)
    }
}

extension ViewController: SideMenuViewControllerDelegate {
    func didSelectRow(atIndexPath indexPath: IndexPath) {
        print("Option selected: \(sideMenu.menuOptions[indexPath.row].title)")
    }
}
