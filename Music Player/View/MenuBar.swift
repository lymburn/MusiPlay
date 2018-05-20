//
//  MenuBar.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//


import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let menuIconNames = ["Trending", "Search", "Playlist", "Favourites", "More"]
    weak var delegate: MenuBarDelegate?
    var iconSelected: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        setCollectionViewConstraints()
    }
    
    func setCollectionViewConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let image : UIImage? = UIImage(named: menuIconNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.image = image
        cell.iconLabel.text = menuIconNames[indexPath.item]
        
        let selectedCell : Bool = (iconSelected == menuIconNames[indexPath.item]) ? true : false
        
        //If the cell is the currently selected one, set to a color. Else, leave as gray
        if selectedCell {
            cell.tintColor = UIColor.blue
            cell.iconLabel.textColor = UIColor.blue
        } else {
            cell.tintColor = UIColor.gray
            cell.iconLabel.textColor = UIColor.gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/5, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Notify view controller to change views
        self.delegate?.menuCellPressed(for: menuIconNames[indexPath.item])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Handle presses on menu cells
protocol MenuBarDelegate: class {
    func menuCellPressed(for sectionName: String)
}
