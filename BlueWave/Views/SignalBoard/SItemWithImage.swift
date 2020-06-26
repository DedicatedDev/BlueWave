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



protocol MessageImgCellDelegate {
    
    func zoomImage(image:UIImage)
    func finishLoadingImage()
    
}
class MessageCell: UITableViewCell {

    var container  = UIView(psEnabled: false)
    var isEnableGraphic:Bool = false
    var originalImg:UIImage?
    
    var delegate:MessageImgCellDelegate?
    
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
        iv.backgroundColor = .black
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
        
        if obj.imagUrl != nil {
            
            let url = URL(string: obj.imagUrl!)
      
            DispatchQueue.main.async {
                
                self.diagramView.kf.indicatorType = .activity
                
                self.diagramView.kf.setImage(
                        with: url,
                        placeholder: nil,
                        options: [
                            .scaleFactor(UIScreen.main.scale),
                            .transition(.fade(1)),
                            .cacheOriginalImage
                    ]) { result in
         
                        switch result {
                        case .success(_):
                            self.originalImg = self.diagramView.image
                            break
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    }
                
            }

        }
        
    }
    
    
    @objc func previewImg(){
        
        guard originalImg != nil else {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "emptyImage"), object: nil)
            
            return
        }
        
        delegate?.zoomImage(image: originalImg!)
    }
    
    
    func setDataHereWithImage(obj:SignalItem){
        
        itemTitleLbl.text = obj.type
        itemValueLbl.text = obj.value
        
    }
    
    override func prepareForReuse() {
        
        diagramView.kf.cancelDownloadTask()
        originalImg = nil
    }
    
    func setupUI(){
        
        self.addSubview(container)
        self.backgroundColor = .clear
        container.backgroundColor = .clear
        
        UIHelper.FillOutSuperView(childView: container, parentView: self)
        
            container.hstack(stack(itemTitleLbl,UIView()),
                         stack(itemValueLbl,diagramView,spacing:10),
                         spacing:10,
                         alignment: .fill,
                         distribution: .fillProportionally).padLeft(20).padRight(30).padTop(5).padBottom(5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(previewImg))
        diagramView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
        
            itemValueLbl.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),
            diagramView.widthAnchor.constraint(equalTo: diagramView.heightAnchor, multiplier: 1.0)
            
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
