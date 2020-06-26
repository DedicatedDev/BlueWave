//
//  SItemCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage
import Kingfisher

struct SignalItem{
    
    var type : String = ""
    var value : String = ""
    var imagUrl:String?
}



class SItemCell: UITableViewCell {

    var container  = UIView(psEnabled: false)
    var isEnableGraphic:Bool = false
    var originalImg:UIImage?
    

    
    var itemTitleLbl :UILabel = {
            let l = UILabel(psEnabled: false)
            l.font = AppFonts.SIGNALITEMTYPE
            l.text = "Item"
            l.backgroundColor = .clear
            l.textAlignment = .left
           return l
       }()
    
    var itemValueLbl :UILabel = {
           let l = UILabel(psEnabled: false)
           l.font = AppFonts.SIGNALITEMVALUE
           l.text = "Value"
           l.backgroundColor = .clear
           l.numberOfLines = 0
           return l
       }()
    
    var diagramView:UIImageView = {
        
        let iv = UIImageView(psEnabled: false)
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setDataHere(obj:SignalItem){
        
        itemTitleLbl.text = obj.type
        itemValueLbl.text = obj.value
        
        print(obj.imagUrl as Any)
        print(obj.type)
        diagramView.image = UIImage()
        diagramView.isUserInteractionEnabled = true
        
       // print(obj.imagUrl)
        
        
        
    }
    
    
  
    func setDataHereWithImage(obj:SignalItem){
        
        itemTitleLbl.text = obj.type
        itemValueLbl.text = obj.value
        
    }
    
    override func prepareForReuse() {
        
        diagramView.sd_cancelCurrentImageLoad()
        diagramView.image = UIImage()
        self.originalImg = nil
    }
    
    func setupUI(){
        
        self.addSubview(container)
        self.backgroundColor = .clear
        container.backgroundColor = .clear
        
        UIHelper.FillOutSuperView(childView: container, parentView: self)
        
            container.hstack(itemTitleLbl,
                        itemValueLbl,
                         spacing:10,
                         alignment: .fill,
                         distribution: .fillProportionally).padLeft(20).padRight(30).padTop(5).padBottom(5)
        
        NSLayoutConstraint.activate([
        
            itemValueLbl.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),
         
            
        ])
            
    }
}


//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct ItemCellRepresentable: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UIView {
//        return SItemCell()
//    }
//
//    func updateUIView(_ view: UIView, context: Context) {
//
//    }
//}
//
//@available(iOS 13.0, *)
//struct ItemCell_Preview: PreviewProvider {
//    static var previews: some View {
//        ItemCellRepresentable()
//            .previewLayout(.fixed(width: 400, height: 60))
//    }
//}
//
//
//#endif
