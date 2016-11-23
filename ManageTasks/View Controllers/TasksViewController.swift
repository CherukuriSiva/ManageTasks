//
//  TasksViewController.swift
//  ManageTasks
//
//  Created by Apple on 28/10/16.
//  Copyright © 2016 Cherukuri. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    var tasksArray: [Dictionary<String, String>] = []
    @IBOutlet var tasksTableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tasksTableView!.register(UITableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasksArray = UserDefaults.standard.object(forKey: "SavedTasksArray") as? [Dictionary <String, String>] ?? [Dictionary <String, String>]()
        tasksTableView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksArray.removeAll()
    }
    
    //tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //make sure you use the relevant array sizes
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")

        let object = tasksArray[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = object["taskName"]!
        cell.detailTextLabel?.text = object["taskDescription"]!
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            tasksArray.remove(at: (indexPath as NSIndexPath).row)
            tasksTableView?.reloadData()
            
            UserDefaults.standard.set(tasksArray, forKey: "SavedTasksArray")
            UserDefaults.standard.synchronize()

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

