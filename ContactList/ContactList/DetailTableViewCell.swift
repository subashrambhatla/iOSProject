//
//  DetailTableViewCell.swift
//  ContactList
//
//  Created by Selasi Afi Gborglah on 19/07/2019.
//  Copyright © 2019 Subash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //data from previous controller
    var nameString:String!
    var imageString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
