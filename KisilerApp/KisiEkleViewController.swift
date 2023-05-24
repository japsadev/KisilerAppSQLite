//
//  KisiEkleViewController.swift
//  KisilerApp
//
//  Created by Salih Yusuf Göktaş on 11.05.2023.
//

import UIKit

class KisiEkleViewController: UIViewController {

	
	@IBOutlet weak var ekleButtonSekil: UIButton!
	@IBOutlet weak var kisiAdTextField: UITextField!
	@IBOutlet weak var kisiTelTextField: UITextField!

	override func viewDidLoad() {
        super.viewDidLoad()

		//ekle butonunun şeklini değiştirmek için yazdık
		ekleButtonSekil.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
		ekleButtonSekil.layer.cornerRadius = 25.0
		ekleButtonSekil.tintColor = UIColor.white
		
    }
    
	@IBAction func ekle(_ sender: Any) {
		
		if let ad = kisiAdTextField.text, let tel = kisiTelTextField.text {
			Kisilerdao().kisiEkle(kisi_ad: ad, kisi_tel: tel)
		}
		
	}
}
