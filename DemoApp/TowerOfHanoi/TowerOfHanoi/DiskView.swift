//
//  DiskView.swift
//  TowerOfHanoi
//
//  Created by Mustafa.saify on 19/10/2021.
//

import UIKit

class DiskView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
    }
    
    func configureWith(disk: Disk) {
        titleLabel.text = disk.name
    }

}
