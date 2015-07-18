//
//  ViewController.swift
//  FriendList
//
//  Created by Chris Snyder on 7/17/15.
//  Copyright (c) 2015 LAKES. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var myFriends = [String]()
    var alertView: UIAlertController?
    var valueToPass: String?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - IBActions

    @IBAction func addButtonPressed(sender: AnyObject)
    {
        alertView = UIAlertController(title: "Hi!", message: "Add a Friend!", preferredStyle: UIAlertControllerStyle.Alert)
        var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)

        alertView?.addAction(okAction)


        alertView?.addTextFieldWithConfigurationHandler ({ (textField) -> Void in
            textField.placeholder = "Enter your Friend"

        })
        let alertActionForTextField = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default)
            { (action) -> Void in
                if let textField = self.alertView?.textFields{
                    let theTextFields = textField as! [UITextField]
                    let friendName = theTextFields[0].text
                    self.myFriends.append(friendName)
                    self.tableView.reloadData()
                    
                }
            }

        alertView?.addAction(alertActionForTextField)

        self.presentViewController(alertView!, animated: true, completion: nil)

    }

    //MARK: - Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "friends" {
            let newVC = segue.destinationViewController as! FriendDetalViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow()
            let currentCell = tableView.cellForRowAtIndexPath(selectedIndexPath!)
            valueToPass = currentCell?.textLabel?.text
            newVC.passedValue = valueToPass


        }

    }
    //MARK: - Table View Delegate and Data Source Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = myFriends[indexPath.row]

        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        myFriends.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }

}

