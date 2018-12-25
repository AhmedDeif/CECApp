//
//  ProjectDescriptionViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 12/3/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectDescriptionViewController: UIViewController {

    @IBOutlet weak var projectDescriptionTableView: UITableView!
    let cellReuseIdentifier = "ProjectDescriptionTableViewCell"
    let customHeaderResuseIdentifier = "ProjectDescriptionCustomHeaderView"
    var additonalHeight: CGFloat?
    var project: ProjectModel?
    var tabBar:  UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        projectDescriptionTableView.delegate = self
        projectDescriptionTableView.dataSource = self
//        self.projectDescriptionTableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)
        self.tabBar?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBar?.tabBar.isHidden = false
    }
    
    func registerCells() {
        self.projectDescriptionTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.projectDescriptionTableView.register(UINib(nibName: customHeaderResuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: customHeaderResuseIdentifier)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first
        if firstTouch?.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }

}

extension ProjectDescriptionViewController: UITableViewDelegate {
    
}

extension ProjectDescriptionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.project?.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProjectDescriptionTableViewCell
        cell.setData(employee: self.project!.employees[indexPath.row])
        cell.parentViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderResuseIdentifier) as! ProjectDescriptionCustomHeaderView
        view.tableViewDelegate = self
        view.setData(project: self.project!)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ToDo: add height of textView
        if additonalHeight != nil {
            return 160 + additonalHeight!
        }
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension ProjectDescriptionViewController: readMoreButtonProtocol {
    
    func readMoreButton(expandView: Bool, additionalHeight: CGFloat) {
        if expandView {
            self.additonalHeight = additionalHeight
        }
        else {
            self.additonalHeight = 0
        }
        self.projectDescriptionTableView.reloadData()
    }
    
}






