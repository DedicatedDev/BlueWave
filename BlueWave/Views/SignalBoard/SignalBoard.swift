//
//  SignalBoard.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import LBTATools

class HeaderTap: UITapGestureRecognizer {
    var section: Int = 0
}

protocol SignalBoardDelegate {
    
    func CallZoomView(img:UIImage)
    
}

class SignalBoard: SemiRadiusView {

    var tv : UITableView = UITableView(frame: CGRect(), style: .grouped)
    var displayN : Int = 0
  
    var viewModel = SignalBModel()
    var delegate: SignalBoardDelegate?
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.register(SItemCell.self, forCellReuseIdentifier: "sitem")
        tv.register(MessageCell.self, forCellReuseIdentifier: "MessageItem")
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.allowsSelection = false
        tv.tableFooterView = UIView(frame: CGRect.zero)
        tv.sectionFooterHeight = 0.0
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
      //  self.translatesAutoresizingMaskIntoConstraints = false
        
        let container = UIView(psEnabled: false)
        container.backgroundColor = .clear
        
        self.addSubview(container)
        
        UIHelper.FillOutSuperView(childView: container, parentView: self)

        let pairCaption : UILabel = {
            let l = UILabel()
            l.text = "PAIR"
            l.font = AppFonts.SiGNALCAPTION
            l.textAlignment = .center
           

           return l
        }()

        let actionCaption  : UILabel = {
            let l = UILabel()
            l.text = "ACTION"
            l.font = AppFonts.SiGNALCAPTION
            l.textAlignment = .center
           
           return l
        }()
        let openPriceCaption : UILabel = {
            let l = UILabel()
            l.text = "OPEN PRICE"
            l.font = AppFonts.SiGNALCAPTION
            l.textAlignment = .center
          

           return l
        }()


        container.stack(hstack(pairCaption,actionCaption,openPriceCaption, spacing:10, alignment: .fill, distribution: .fillEqually).withHeight(40),tv).padLeft(10).padRight(10)
        
    }
    
    
    func updateData(obj:[SignalModel]){
        
        print(obj)
        
        viewModel.signalSrc = obj
        viewModel.createTableViewData()
    
        DispatchQueue.main.async {
            self.tv.reloadData()
        }
        
        
    }
}

extension SignalBoard : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return viewModel.numberOfItemAtSignal(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 6{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageItem", for: indexPath) as! MessageCell
            
            viewModel.setDataForCell(cell: cell, section: indexPath.section, index: indexPath.row)
            
             cell.delegate = self
            
            return cell
        }else{
            
          let cell = tableView.dequeueReusableCell(withIdentifier: "sitem", for: indexPath) as! SItemCell
            
            viewModel.setDataForCell(cell: cell, section: indexPath.section, index: indexPath.row)
                   
                   
            return cell
        }
       
       
       
        
   
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        
        viewModel.numberOfSignal()
    }
    
        
    
    @objc func touchHeader(sender: HeaderTap){
        
        let section = sender.section
        
        var indexPaths = [IndexPath]()
        
        for row in viewModel.tableViewData[section].cellData.indices
        {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
    
        let isExpandable = viewModel.tableViewData[section].isExpand
        viewModel.tableViewData[section].isExpand = !isExpandable
       
        if isExpandable {
            tv.deleteRows(at: indexPaths, with: .fade)
        }else{
            tv.insertRows(at: indexPaths, with: .fade)
        }
        
        
    }
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 50
    }
    
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let tapGesture =  HeaderTap(target: self, action: #selector(touchHeader(sender:)))
               
       tapGesture.section = section
               
       let headerView = UIView()
                      
       var headerContent: SignalModel{
            
           return viewModel.getDataBySection(section: section)
           
       }
        
   
      
       var pairCaption : UILabel{
           let l = UILabel()
           l.text = headerContent.pair
           l.font = AppFonts.TABBARITEMFONT
           l.textAlignment = .center

          return l
       }

       var actionCaption  : UILabel{
           let l = UILabel()
        
        if !headerContent.action!{
                l.textColor = AppColors.BTNCOLOR
                l.text = ActionType.BUY
            }else{
                l.textColor = .red
                l.text = ActionType.SELL
            }
          
           l.font = AppFonts.TABBARITEMFONT
           l.textAlignment = .center
          return l
       }
       var openPriceCaption : UILabel{
           let l = UILabel()
           l.text = headerContent.openPrice
           l.font = AppFonts.TABBARITEMFONT
           l.textAlignment = .center

          return l
       }
            
        headerView.hstack(pairCaption,actionCaption,openPriceCaption, spacing: 20, alignment: .fill, distribution: .fillEqually).withHeight(50)
       
           if section % 2 != 0 {
            headerView.backgroundColor = AppColors.GREYBGCOLOR
           }else{
            headerView.backgroundColor = UIColor(hexString: "#E0E3E6")
           }
         
          headerView.addGestureRecognizer(tapGesture)
        
         return headerView
      
      }
    


}

extension SignalBoard:MessageImgCellDelegate{
    func finishLoadingImage() {
        
        print("Okay")
        //self.tv.reloadData()
    }
    
        
    func zoomImage(image: UIImage) {

        delegate?.CallZoomView(img: image)
        
    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SignalBoardRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return SignalBoard()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct SignalBoard_Preview: PreviewProvider {
    static var previews: some View {
        SignalBoardRepresentable()
            .previewDevice("iPhone SE")
    }
}


#endif
