//
//  CategoriesHeader.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 09/08/2021.
//

import UIKit

protocol CategoriesHeaderDelegate {
    func toggleSection(_ section: Int)
}

class CategoriesHeader: UICollectionReusableView {

    var delegate: CategoriesHeaderDelegate?
    var section: Int = 0
    
    lazy var titleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = .black
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ImageView : UIImageView = {
        let Image = UIImageView()
        Image.tintColor = .black
        Image.backgroundColor = .clear
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Image
    }()
    
    lazy var toggleButton : UIImageView = {
        let Image = UIImageView()
        Image.tintColor = .black
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ImageView,titleLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(15)
        Stack.distribution = .fillProportionally
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        addSubview(BackgroundView)
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(10)).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        BackgroundView.addSubview(toggleButton)
        toggleButton.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        toggleButton.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        toggleButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-10)).isActive = true
        toggleButton.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor).isActive = true

        BackgroundView.addSubview(Stack)
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Stack.centerYAnchor.constraint(equalTo: BackgroundView.centerYAnchor).isActive = true
        Stack.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor ,constant: ControlX(20)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-50)).isActive = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CategoriesHeader.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
    guard let cell = gestureRecognizer.view as? CategoriesHeader else {
    return
    }
    delegate?.toggleSection(cell.section)
    }
    
    func setCollapsed(_ Collapsed:Bool) {
    toggleButton.transform = CGAffineTransform(rotationAngle: !Collapsed ? 0 : "lang".localizable == "en" ? (-.pi / 2) :(.pi / 2))
    }
}

