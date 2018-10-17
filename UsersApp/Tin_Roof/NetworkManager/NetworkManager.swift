//
//  NetworkManager.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: class {
	func updateUsers()
}
class NetworkManager: NSObject {
	
	weak var delegate: NetworkManagerDelegate?
	lazy var usersDao = UserDao.userDaoInstance
	
	
	func getUsers() {
		let url = URL(string: networkRequest.usersURL)
		
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			if error == nil {
				//parsing
				do {
					if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String: Any]] {
						//ParseInfo
						self.usersDao.parseUsersInfo(jsonObject)
						DispatchQueue.main.async {
							self.delegate?.updateUsers()
						}
					}
				} catch {
					print("error parsing data")
				}
			}
		}
		task.resume()
	}
}


struct networkRequest {
	static let usersURL = "http://jsonplaceholder.typicode.com/todos"
	
}
