//
//  ViewController.swift
//  KisilerApp
//
//  Created by Salih Yusuf Göktaş on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var kisilerTableView: UITableView!
	
	var kisilerListe = [Kisiler]()
	
	var aramaYapiliyorMu = false
	var aramaKelimesi:String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		veritabaniKopyala()
		
		kisilerTableView.delegate = self
		kisilerTableView.dataSource = self
		
		searchBar.delegate = self
		
	}

	override func viewWillAppear(_ animated: Bool) {
		
		if aramaYapiliyorMu {
		
			kisilerListe = Kisilerdao ().aramaYap(kisi_ad: aramaKelimesi!)
			}else{
		kisilerListe = Kisilerdao () .tumKisilerAl ()
	}
		
		kisilerTableView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let indeks = sender as? Int

		if segue.identifier == "toGuncelle" {
			let gidilecekVC = segue.destination as! KisiGuncelleViewController
			
			gidilecekVC.kisi = kisilerListe[indeks!]
			
		}

		if segue.identifier == "toDetay" {

		let gidilecekVC = segue.destination as! KisiDetayViewController

		gidilecekVC.kisi = kisilerListe[indeks!]

		}
		
	}

	func veritabaniKopyala(){
		
		let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
		
		let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		
		let fileManager = FileManager.default
		
		let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
		
		if fileManager.fileExists(atPath: kopyalanacakYer.path) {
			print("Veritabanı zaten var.Kopyalamaya gerek yok")
		}else{
			do {
				
				try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
				
			}catch{
				print(error)
			}
		}
	}
	
}

//Table View ile ilgili protocolleri daha clean code olsun diye extension ile yaptık
extension ViewController:UITableViewDelegate,UITableViewDataSource {
	
	//numberOfSections -> kaç bölüm olacak
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	//numberOfRowsInSection -> kaç tane veri olacak
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kisilerListe.count
	}
	
	//cellForRowAt -> hücreyi tanımladık
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let kisi = kisilerListe[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
		
		cell.kisiYaziLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"

		return cell
	}
	
	//tıklanılan satırın verisini alır karşı tarafa geçirir
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
	}
	
	//satırı yana çekince sil gibi işlem yapmamızı sağlayan action atıyoruz
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		
		let silAction = UITableViewRowAction(style: .default, title: "Sil", handler: {(action:UITableViewRowAction, indexPath:IndexPath)-> Void in
			
			let kisi = self.kisilerListe[indexPath.row]
			
			Kisilerdao().kisiSil(kisi_id: kisi.kisi_id!)
			
			self.kisilerListe = Kisilerdao().tumKisilerAl()
			
			self.kisilerTableView.reloadData()
		
			if self.aramaYapiliyorMu {
				
				self.kisilerListe = Kisilerdao ().aramaYap(kisi_ad: self.aramaKelimesi!)
				
			}else{
					self.kisilerListe = Kisilerdao () .tumKisilerAl ()
		}
			
			self.kisilerTableView.reloadData()
		
			
		})
		
		let guncelleAction = UITableViewRowAction(style: .normal, title: "Güncelle", handler: {(action:UITableViewRowAction, indexPath:IndexPath)-> Void in
			
			print("Güncelle tıklandı \(self.kisilerListe[indexPath.row])")
			
			//Aşağıdaki kod ViewController arası geçişi sağlıyor
			self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
			
	})
		return[silAction,guncelleAction]
}
											 }
//Search Bar ile ilgili protocolleri daha clean code olsun diye extension ile yaptık
extension ViewController:UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		aramaKelimesi = searchText

		if searchText == "" {
		aramaYapiliyorMu = false
		}else{
		aramaYapiliyorMu = true
		}
		
		kisilerListe = Kisilerdao ().aramaYap(kisi_ad: searchText)

		kisilerTableView.reloadData ()
		
	}
}


