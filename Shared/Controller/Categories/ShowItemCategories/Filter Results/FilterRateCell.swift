//
//  FilterRateCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 24/03/2022.
//

import UIKit

protocol FilterRateCellDelegate {
    func RateAction(_ Cell:FilterRateCell)
}

class FilterRateCell: UITableViewCell {

    var Delegate : FilterRateCellDelegate?
    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        Button.isEnabled = false
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionCheckbox() {
        Delegate?.RateAction(self)
    }
    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.9998577237, green: 0.8516119123, blue: 0.2453690469, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.textFont = UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(CheckboxButton)
        CheckboxButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        CheckboxButton.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlX(-8)).isActive = true
        CheckboxButton.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(8)).isActive = true
        CheckboxButton.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        
        addSubview(ViewRating)
        ViewRating.leadingAnchor.constraint(equalTo: CheckboxButton.trailingAnchor , constant: ControlX(15)).isActive = true
        ViewRating.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        ViewRating.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        ViewRating.centerYAnchor.constraint(equalTo: self.centerYAnchor , constant: ControlX(5)).isActive = true
        
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCheckbox)))
        
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
