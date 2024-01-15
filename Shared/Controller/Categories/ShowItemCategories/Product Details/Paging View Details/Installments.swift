//
//  Installments.swift
//  Volt (iOS)
//
//  Created by Emojiios on 16/02/2022.
//

import UIKit

struct InstallmentsData {
    var Duration = String()
    var Installment = Int()
}

class InstallmentsCell: UITableViewCell  {
    
    func IsFristRow(IsFrist:Bool,indexPath:IndexPath,DataDetails:[InstallmentsData]) {
        if IsFrist {
        let attributedString = NSMutableAttributedString(string: "Duration".localizable, attributes: [
        .font: UIFont(name: "Muli-Bold" ,size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
        .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ])

        attributedString.append(NSAttributedString(string: " ", attributes: [
        .font: UIFont(name: "Muli-Bold" ,size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
        .foregroundColor: UIColor.clear
        ]))
            
        attributedString.append(NSAttributedString(string: "Months".localizable, attributes: [
        .font: UIFont(name: "Muli-Bold" ,size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
        .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ]))
        LeftLabel.attributedText = attributedString
                    
        LeftLabel.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        RightLabel.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        RightLabel.text = "Installment".localizable
        RightLabel.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        }else{
        LeftLabel.text = DataDetails[indexPath.row - 1].Duration
        let Installment = "lang".localizable == "en" ? "\(DataDetails[indexPath.row - 1].Installment)":"\(DataDetails[indexPath.row - 1].Installment)".NumAR()
        RightLabel.text = "\("EGP".localizable) \(Installment)"
        LeftLabel.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.9950696826, green: 0.9619323611, blue: 0.889089644, alpha: 1) : #colorLiteral(red: 0.9163123965, green: 0.875754416, blue: 0.787006855, alpha: 1)
        RightLabel.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.9950696826, green: 0.9619323611, blue: 0.889089644, alpha: 1) : #colorLiteral(red: 0.9163123965, green: 0.875754416, blue: 0.787006855, alpha: 1)
        RightLabel.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        LeftLabel.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        }
    }
    
    lazy var LeftLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()
    
    lazy var RightLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()
    
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LeftLabel,RightLabel])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(4)
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(StackView)
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(2)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


