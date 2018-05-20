//
//  SideMenuViewController.swift
//  SideMenu
//
//  Created by Santiago Carmona Gonzalez on 5/20/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import UIKit

public protocol SideMenuViewControllerDelegate: class {
    func didSelectRow(atIndexPath indexPath: IndexPath)
}

public class SideMenuViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Vars & Constants


    public var menuOptions: [SideMenuOption] = []
    public weak var delegate: SideMenuViewControllerDelegate?
    var backView: UIView! = UIView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseBackView()
        setupTableView()
    }

    // MARK: - Methods

    private func setupCloseBackView() {
        backView.frame = view.frame
        view.insertSubview(backView, at: 0)
        setupCloseTapGesture()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let nib = UINib(nibName: SideMenuTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
    }

    private func setupCloseTapGesture() {
        let closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        backView.addGestureRecognizer(closeTapGesture)
    }

    @objc func closeMenu() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource

extension SideMenuViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier)

        guard let menuCell = cell as? SideMenuTableViewCell else {
            assertionFailure("Unexpected cell of type: \(type(of: cell))")
            return UITableViewCell()
        }

        menuCell.setCell(data: menuOptions[indexPath.row])
        return menuCell
    }
}

// MARK: - TableView Delegate

extension SideMenuViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is SideMenuViewController {            
            return SideMenuTransition(originFrame: self.view.frame)
        }
        return nil
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed is SideMenuViewController {
            return SideMenuTransition(originFrame: self.view.frame, dismissing: true)
        }
        return nil
    }
}