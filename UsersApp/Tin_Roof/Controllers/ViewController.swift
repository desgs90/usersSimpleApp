//
//  ViewController.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//MARK:- IBOutlets
	@IBOutlet weak var tableView: UITableView!
	
	//MARK: Lazy var
	lazy var usersDao = UserDao.userDaoInstance
	
	//MARK: - File Private properties
	fileprivate var networkManager = NetworkManager()
	fileprivate var userIdSelected = ""
	
	//MARK: - Cycle of life
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.tableView.register(UINib(nibName: "MainCustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCustomCellTableViewCell")
		networkManager.delegate = self
		networkManager.getUsers()
	}

	//MARK: Memory Warning
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	//MARK: FilePrivate
	fileprivate func localUpdateUsers() {
		self.tableView.reloadData()
	}
}

//MARK: - Table view delegate and datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usersDao.getAllUserInfoOrdered().count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MainCustomCellTableViewCell") as! MainCustomCellTableViewCell
		let row = indexPath.row
		
		let userId = usersDao.getAllUserInfoOrdered()[row]
		cell.cellTitle.text = "\(userId.userId)"
		cell.cellCounter.text = "\(userId.uncompleted)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = indexPath.row
		userIdSelected = usersDao.getAllUserInfoOrdered()[row].userId
		performSegue(withIdentifier: "goToDetail", sender: nil)
	}
}

//MARK:- Delegate Networking
extension ViewController: NetworkManagerDelegate {
	func updateUsers() {
		self.localUpdateUsers()
	}
}

//MARK: - Segues
extension ViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToDetail" {
			if userIdSelected.isEmpty {
				return;
			}
			if let vc = segue.destination as? SecondViewController {
				vc.userselected = userIdSelected
			}
			
		}
	}
}

