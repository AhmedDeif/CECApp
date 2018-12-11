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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        projectDescriptionTableView.delegate = self
        projectDescriptionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerCells() {
        self.projectDescriptionTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.projectDescriptionTableView.register(UINib(nibName: customHeaderResuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: customHeaderResuseIdentifier)
    }
    


}

extension ProjectDescriptionViewController: UITableViewDelegate {
    
}

extension ProjectDescriptionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProjectDescriptionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderResuseIdentifier) as! ProjectDescriptionCustomHeaderView
        view.tableViewDelegate = self
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






