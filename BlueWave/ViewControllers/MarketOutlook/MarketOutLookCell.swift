//
//  MarketOurLookCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import WebKit


class MarketOutLookCell: UITableViewCell {

    var container = UIView(psEnabled: false)
    
    let videoView : YoutubePlayerView = {
        
        let i = YoutubePlayerView(psEnabled: false)
        i.layer.cornerRadius = 8
        i.backgroundColor = .black
        return i
    }()
    
    let playerVars: [String: Any] = [
        "controls": 1,
        "modestbranding": 1,
        "playsinline": 1,
        "origin": "https://youtube.com"
    ]
    
    let videoTitle : UILabel = {
        
        let l = UILabel(psEnabled: false)
        l.font = UIFont(name: AppFontNames.InterBold, size: 15)
        l.text = "Title: Where Will Market Move?"
        l.numberOfLines = 0
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()
    
    let subTitle : UILabel = {
        
        let l = UILabel(psEnabled: false)
        l.font =  UIFont(name: AppFontNames.InterRegular, size: 15)
        l.text = "Weekly Roket Outlook , 24 Nov 2019"
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
        
    }()
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                 super.init(style: style, reuseIdentifier: reuseIdentifier)
     
                 setupCell()
             }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    

    required init?(coder: NSCoder) { 
        super.init(coder: coder)
    }
    
    func setupCell(){
         //self.addSubview(container)
        
        self.stack(videoView,stack(videoTitle,subTitle), spacing: 10, alignment: .center, distribution: .fill).padTop(10).padLeft(10).padRight(10).padBottom(10)
        
        videoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: 0.65).isActive = true
   
        videoView.clipsToBounds = true
        videoView.layer.cornerRadius = 20
        
    }
    
    func setVideo(obj:MOLModel){
        
        let url = URL(string: obj.videoLink ?? "")
        
        print(url as Any)
        videoView.loadWithVideoId(obj.videoLink ?? "", with: playerVars)
    
        videoTitle.text = obj.videoTitle
        subTitle.text = obj.subTitle
    
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MarketOurLookCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return MarketOutLookCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct MarketOurLookCell_Preview: PreviewProvider {
    static var previews: some View {
        MarketOurLookCellRepresentable()
            .previewLayout(.fixed(width: 414, height: 220))
    }
}


#endif

