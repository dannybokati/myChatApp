//
//  AvatarPickerVC.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/17/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import UIKit

protocol AvatarDelegate: NSObjectProtocol {
    var imageName: String? {get set}
}

class AvatarPickerVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var backBtn: UIButton!
   weak var delegate: AvatarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    deinit {
        print("AvatarPickerVC")
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true) {
            print("dismissed")
        }
    }
    @IBAction func segmentControlAction(_ sender: Any) {
        collectionView.reloadData()
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as! AvatarCell
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.avatarImage.image = UIImage(named: "dark\(indexPath.row)")
            break;
        case 1:
            cell.avatarImage.image = UIImage(named: "light\(indexPath.row)")
            break;
        default:
            cell.avatarImage.image = UIImage(named: "dark\(indexPath.row)")
            break;
        }
        cell.backgroundColor = UIColor.lightGray
        cell.layer.cornerRadius = cell.layer.frame.height / 2
//        \(avatarType)\(indexPath.row)"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if delegate != nil {
                delegate?.imageName = "dark\(indexPath.row)"
                dismiss(animated: true, completion: nil)
            }
            break;
        case 1:
            if delegate != nil {
                delegate?.imageName = "light\(indexPath.row)"
                dismiss(animated: true, completion: nil)
            }
            break;
        default:
            if delegate != nil {
                delegate?.imageName = "dark\(indexPath.row)"
                dismiss(animated: true, completion: nil)
            }
             break;
        }
        
    }
    

    
}
