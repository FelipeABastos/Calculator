//
//  SavesViewController.swift
//  Calculator
//
//  Created by Felipe Amorim Bastos on 09/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class SavesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    
    var numbersSaved: Array<Result> = []
    
    @IBOutlet var tbResults: UITableView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numbersSaved = get()
        
        tbResults?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersSaved.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result: Result = numbersSaved[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! NumbersCell
        cell.loadUI(item: result)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            numbersSaved.remove(at: indexPath.row)
            
            var numbersDictionary = UserDefaults.standard.value(forKey: "results") as? Array<Dictionary<String,String>>
            numbersDictionary?.remove(at: indexPath.row)
            UserDefaults.standard.set(numbersDictionary, forKey: "results")
        }
        tbResults?.reloadData()
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func get() -> Array<Result> {
        
        var list: Array<Result> = []
        
        if let results = UserDefaults.standard.array(forKey: "results") as? Array<Dictionary<String, String>> {
            
            for item in results {
                
                let object = Result(name: item["name"] ?? "",
                                    result: item["result"] ?? "")
                list.append(object)
            }
        }
        return list
    }
    
    @IBAction func backButton() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
