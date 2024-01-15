//
//  FilterPriceCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 24/03/2022.
//

import UIKit

protocol FilterPriceDelegate {
    func SliderAction(minValue:Int,maxValue:Int)
}

class FilterPriceCell: UITableViewCell, RangeSeekSliderDelegate {
        

    var Delegate:FilterPriceDelegate?
    lazy var SliderPrice : RangeSeekSlider = {
    let View = RangeSeekSlider()
        View.delegate = self
        View.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.handleColor = #colorLiteral(red: 0.9606148601, green: 0.7349409461, blue: 0.1471969187, alpha: 1)
        View.minLabelColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.maxLabelColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.colorBetweenHandles = #colorLiteral(red: 0.9606148601, green: 0.7349409461, blue: 0.1471969187, alpha: 1)
        View.lineHeight = ControlWidth(6)
        View.handleDiameter = ControlWidth(25.0)
        View.selectedHandleDiameterMultiplier = 1.3
        View.numberFormatter.numberStyle = .none
        View.numberFormatter.maximumFractionDigits = 0
        View.numberFormatter.locale = Locale(identifier: "lang".localizable)
        View.minLabelFont = UIFont(name: "Muli-Bold" ,size: ControlWidth(10)) ?? UIFont.italicSystemFont(ofSize: ControlWidth(10))
        View.maxLabelFont = UIFont(name: "Muli-Bold" ,size: ControlWidth(10)) ?? UIFont.italicSystemFont(ofSize: ControlWidth(10))
        View.numberFormatter.positivePrefix = ""
        View.numberFormatter.positiveSuffix = "EGP".localizable
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlX(60)).isActive = true
    return View
    }()
    
    func didStartTouches(in slider: RangeSeekSlider) {}
    
    var MinValue : Int?
    var MaxValue : Int?
    func didEndTouches(in slider: RangeSeekSlider) {
    if let Min = MinValue ,let Max = MaxValue {
    Delegate?.SliderAction(minValue: Min, maxValue: Max)
    }
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        MinValue = Int(minValue)
        MaxValue = Int(maxValue)
        MinPrice.text = "lang".localizable == "en" ? "\(Int(minValue))":"\(Int(minValue))".NumAR()
        MaxPrice.text = "lang".localizable == "en" ? "\(Int(maxValue))":"\(Int(maxValue))".NumAR()
    }
    
    lazy var MinPrice : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.layer.borderWidth = ControlWidth(1)
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var LabelTo : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "To".localizable
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var MaxPrice : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.layer.borderWidth = ControlWidth(1)
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [MinPrice,LabelTo,MaxPrice])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlX(40)).isActive = true
        return Stack
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SliderPrice,StackLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(Stack)
        Stack.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        Stack.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
