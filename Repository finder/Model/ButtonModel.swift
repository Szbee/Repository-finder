//
//  ButtonModel.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 11..
//

import UIKit

class ButtonModel: UIButton {

    override init(frame: CGRect) {
           super.init(frame: frame)
           setUpButton()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setUpButton()
       }
    
    private func setUpButton(){
        backgroundColor = UIColor.blue
        layer.cornerRadius = 10
        tintColor = .white
    }

}
