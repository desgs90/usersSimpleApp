//
//  UserDAO.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import Foundation

class UserDao: NSObject {
	
	//MARK: - Instance
	public static let userDaoInstance = UserDao()
	
	//MARK:- Fileprivate vars
	fileprivate var allUsers = [User]()
	fileprivate var pendingTodoByUser = [String:[String:Bool]]()
	
	//MARK: - Public functions
	
	/**
	This function will Parse all the user info
	*/
	public func parseUsersInfo(_ data: [[String: Any]]) {
		for item in data {
			var userID = ""
			var id = ""
			var title = ""
			var completed = false
			
			if let existsUserId = item["userId"] {
				userID = "\(existsUserId as! Int)"
			}
			if let existsId = item["id"] {
				id  = "\(existsId as! Int)"
			}
			if let existsTitle = item["title"] {
				title = existsTitle as! String
			}
			if let existsCompleted = item["completed"] {
				completed = existsCompleted as! Bool
			}
			
			//Add the user in the all users Array
			let newUser = User(userID: userID, id: id, title: title, completed: completed)
			allUsers.append(newUser)
			
			//Then we add it filtered under next format
			//userID -> todoTitle:completed
			
			if pendingTodoByUser.keys.contains(userID) {
				if let todos = pendingTodoByUser[userID] {
					var newTodos = todos
					newTodos[title] = completed
					pendingTodoByUser[userID] = newTodos
				}
			} else {
				pendingTodoByUser[userID] = [title:completed]
			}
		}
	}
	
	/**
	This function will return all the users ordered by uncompleted todos
	- returns:[(userId:String,uncompleted:Int)] -> AllUsers
	*/
	public func getAllUserInfoOrdered() -> [(userId:String,uncompleted:Int)] {
		//order data by uncompleted
		var tempResult = [(userId:String,uncompleted:Int)]()
		for key in pendingTodoByUser.keys {
			var uncompleted = 0
			if let todos = pendingTodoByUser[key] {
				for keyInTods in todos.keys {
					if todos[keyInTods] == false {
						uncompleted += 1
					}
				}
			}
			tempResult.append((userId: key, uncompleted: uncompleted))
		}
		return tempResult.sorted(by: {$1.uncompleted < $0.uncompleted})
	}
	
	/**
	This function will return all the info by the selected user
	- parameter: UserId
	- returns:[(userId:String,uncompleted:Int)] -> AllUsers
	*/
	public func getAllTodosByUserId(_ userID: String) -> [String: Bool] {
		guard let data = pendingTodoByUser[userID] else {
			return [:]
		}
		return data
	}
}
