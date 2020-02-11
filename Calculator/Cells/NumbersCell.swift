//
//  numbersCell.swift
//  Calculator
//
//  Created by Felipe Amorim Bastos on 09/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation
import UIKit

class NumbersCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel?
    @IBOutlet var lblResult: UILabel?
    
    func loadUI(item: Result) {
        
        lblName?.text = item.name
        lblResult?.text = item.result
    }
}
