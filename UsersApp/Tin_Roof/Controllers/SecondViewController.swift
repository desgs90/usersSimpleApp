//
//  SecondViewController.swift
//  Tin_Roof
//
//  Created by Diego  on 10/17/18.
//  Copyright © 2018 Diego Santiago. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
	//MARK: - IBOutlets
	@IBOutlet weak var textView: UITextView!
	
	//MARK: Lazy var
	lazy var usersDao = UserDao.userDaoInstance
	
	public var userselected = ""
	override func viewDidLoad() {
        super.viewDidLoad()
		self.title = userselected
        // Do any additional setup after loading the view.
		let userInfor = usersDao.getAllTodosByUserId(userselected)
		var stringToShow = ""
		var count = 1
		for (key,value) in userInfor {
			stringToShow.append("\(count) - Todo: \(key)" + "\n" + "Done: \(value)\n\n")
			count += 1
		}
		textView.text = stringToShow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
