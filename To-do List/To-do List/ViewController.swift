//
//  ViewController.swift
//  To-do List
//
//  Created by 鄭羽辰 on 2018/12/16.
//  Copyright © 2018 鄭羽辰. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
     //loaded phone's data to string array
    var toDos = UserDefaults.standard.stringArray(forKey: "todos") ?? [String]()
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "arial", size: 24)
        return cell
        
    }
    //table row shows delete button when sliding
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDos.remove(at: indexPath.row)
            UserDefaults.standard.set(toDos, forKey: "todos")
            myTableView.reloadData()
        }
    }
    
    //Selected row not to be highlighted
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    //Press cell's "i" button
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let secondVC = tabBarController?.viewControllers?[1] as? SecondViewController{
            secondVC.selectedIndexRowFromViewOne = indexPath.row
        }
        //Go to next scene
        tabBarController?.selectedIndex = 1
    }
    @IBOutlet weak var myTableView: UITableView!
    
    /*
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }*/
    
    @objc func handleRefresh(){
        //Reload Data
        myTableView.reloadData()
        //Stop animation and recover table cell position
        myTableView.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //should follow "UITableViewDataSource,UITableViewDelegate" these two delegates
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //pull down and refresh
        myTableView.refreshControl = UIRefreshControl()
        myTableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //pull down refreshing sign
        myTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating")
        myTableView.refreshControl?.tintColor = .white
        
        /*
        //change tableview cell position through pull gesture,make tableview is editing status
        myTableView.isEditing = true
        */
        
    }
}

