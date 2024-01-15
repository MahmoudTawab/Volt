//
//  DetailsImageCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/02/2022.
//

import UIKit
import AVKit
import AVFoundation

protocol DetailsImageDelegate {
    func ActionImage(_ Cell:DetailsImageCell)
}

class DetailsImageCell: UICollectionViewCell {
    
    var Delegate:DetailsImageDelegate?
    lazy var Image:UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSelect)))
        return ImageView
    }()
    
    @objc func ImageSelect() {
    Delegate?.ActionImage(self)
    }
    
    lazy var playButton:UIButton = {
        let button  = UIButton(type: .custom)
        button.isHidden = true
        button.setBackgroundImage(UIImage(named: "Group 26060"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ImageSelect), for: .touchUpInside)
        return button
    }()

    
    override init(frame:CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOpacity = 0.6
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        
        addSubview(Image)
        Image.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(5)).isActive = true
        Image.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-5)).isActive = true
        Image.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(40)).isActive = true
        Image.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-40)).isActive = true

        addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: Image.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: Image.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: ControlWidth(64)).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: ControlWidth(64)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


func localMediaPhoto(imageName: String, caption: String) -> Media {
   guard let image = UIImage(named: imageName) else {
       fatalError("Image is nil")
   }
   
   let photo = Media(image: image, caption: caption)
   return photo
}

func webMediaPhoto(url: String, caption: String?) -> Media {
   guard let validUrl = URL(string: url) else {
       fatalError("Image is nil")
   }
   
   var photo = Media()
   if let _caption = caption {
       photo = Media(url: validUrl, caption: _caption)
   } else {
       photo = Media(url: validUrl)
   }
   return photo
}

func webMediaVideo(url: String, previewImageURL: String? = nil) -> Media {
   guard let validUrl = URL(string: url) else {
       fatalError("Video is nil")
   }

   let photo = Media(videoURL: validUrl, previewImageURL: URL(string: previewImageURL ?? ""))
   return photo
}
