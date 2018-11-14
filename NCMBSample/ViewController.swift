//
//  ViewController.swift
//  NCMBSample
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {

    @IBOutlet weak var sampleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func save(_ sender: Any) {
        let object = NCMBObject(className: "Message")
        object?.setObject(sampleTextField.text, forKey: "Text")
        object?.saveInBackground({ (error) in
            if error != nil{
                //エラーが発生したら
                print("error")
            }else{
                //保存に成功したら
                print("success")
            }
        })
    }
    @IBAction func loadData(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        //絞り込み
        //        query?.whereKey("text", equalTo: "おはよう")
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                //error
                print("error")
            }else{
                print(result)
                var messages = result as! [NCMBObject]
                print(messages.last)
                var text = messages.last?.object(forKey: "Text") as! String
                print(text)
                
                self.sampleTextField.text = text
            }
        })
    }
    
    @IBAction func update(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("Text", equalTo: "こんにちわ")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }else{
                let messages = result as! [NCMBObject]
                let textObject = messages.first
                textObject?.setObject("こんばんわ", forKey: "Text")
                textObject?.saveInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }else{
                        print("Update Succeed")
                    }
                })
            }
        })
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("Text", equalTo: "テスト")
        query?.findObjectsInBackground({ (result,error ) in
            if error != nil{
                print(error)
            }else{
                let messages = result as! [NCMBObject]
                let textObject = messages.first
                textObject?.deleteInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }else{
                        print("Delete succeed")
                    }
                })
            }
        })
    }
    
}

