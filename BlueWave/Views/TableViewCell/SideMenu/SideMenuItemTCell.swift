//
//  SideMenuItemTCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class SideMenuItemTCell: UITableViewCell {

    var container  = UIView(psEnabled: false)
    var itemImgView : UIImageView = {
        let i = UIImageView(psEnabled: false)
        i.tintColor = AppColors.MAINCOLOR
        i.image = #imageLiteral(resourceName: "user")
        i.contentMode = .scaleAspectFill
        return i
    }()
    var itemTitleLbl :UILabel = {
        let l = UILabel(psEnabled: false)
        l.font = AppFonts.MAINFONT
        l.text = "Log Out"
        return l
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
    
    func setupUI(){
        
        self.addSubview(container)
        container.fillSuperview()
        
        container.hstack(stack(itemImgView).withWidth(48).withHeight(48),
                         stack(itemTitleLbl).withHeight(20),
                    spacing:30,
                    alignment: .fill,
            distribution: .fill).padLeft(30).padTop(10).padBottom(10)
       
    
        UIHelper.FillOutSuperView(childView: container, parentView: self)
       
        
    }
    
    func setDataCell(obj:SideMenuItem){
        
        itemImgView.image = obj.itemImag
        itemTitleLbl.text = obj.itemTitle
        
    }
    
    
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SideMenuItemRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return SideMenuItemTCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct SideMenuItemCell_Preview: PreviewProvider {
    static var previews: some View {
        SideMenuItemRepresentable()
            .previewLayout(.fixed(width: 400, height: 80))
    }
}


#endif

