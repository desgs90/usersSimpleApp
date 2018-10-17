//
//  User.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import Foundation

class User: NSObject {
	
	public var userID:String
	public var id: String
	public var title: String
	public var completed:Bool
	
	public init(userID: String, id: String, title: String, completed: Bool) {
		self.userID = userID
		self.id = id
		self.title = title
		self.completed = completed
	}
}
