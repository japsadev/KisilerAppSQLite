//
//  KisiGuncelleViewController.swift
//  KisilerApp
//
//  Created by Salih Yusuf Göktaş on 11.05.2023.
//

import UIKit

class KisiGuncelleViewController: UIViewController {
	
	@IBOutlet weak var guncelleButtonSekil: UIButton!
	@IBOutlet weak var kisiAdTextField: UITextField!
	@IBOutlet weak var kisiTelTextField: UITextField!
	
	var kisi:Kisiler?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		//guncelle butonunun şeklini değiştirmek için yazdık
		guncelleButtonSekil.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
		guncelleButtonSekil.layer.cornerRadius = 25.0
		guncelleButtonSekil.tintColor = UIColor.white
		
		if let k = kisi {
			kisiAdTextField.text = k.kisi_ad
			kisiTelTextField.text = k.kisi_tel
		}
    }
    
	@IBAction func guncelle(_ sender: Any) {
		
		if let k = kisi,let ad = kisiAdTextField.text , let tel = kisiTelTextField.text {
			
		Kisilerdao().kisiGuncelle(kisi_id: k.kisi_id!, kisi_ad: ad, kisi_tel: tel)
	}
		
}
	
}
