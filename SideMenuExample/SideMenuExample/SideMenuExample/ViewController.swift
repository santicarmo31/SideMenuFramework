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

    private lazy var menu: SideMenuViewController = {
        guard let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController else {
            return SideMenuViewController()
        }
        menu.delegate = self
        menu.transitioningDelegate = self
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showMenu(_ sender: Any) {
        present(menu, animated: true, completion: nil)
    }
}

extension ViewController: SideMenuViewControllerDelegate {
    func didSelectRow(atIndexPath indexPath: IndexPath) {
        print("Option selected: \(menu.menuOptions[indexPath.row].title)")
    }
}
