//
//  SecondViewController.swift
//  To-do List
//
//  Created by 鄭羽辰 on 2018/12/17.
//  Copyright © 2018 鄭羽辰. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController,UITextViewDelegate {
    var selectedIndexRowFromViewOne:Int?
    //Change status bar's color
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBOutlet weak var myTextViewInput: UITextView!
    @IBOutlet weak var myButton: UIButton!
    /*
    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        //change button text
        if sender.text != ""{
            myButton.setTitle("OK", for: .normal)
        }else{
            myButton.setTitle("Back", for: .normal)
        }
    }
    */
    func textViewDidChange(_ textView: UITextView) {
        //change button text
        if textView.text != ""{
            myButton.setTitle("OK", for: .normal)
        }else{
            myButton.setTitle("Back", for: .normal)
        }
    }
   
    @IBAction func textButtonPressed(_ sender: UIButton) {
        
            guard let FVC = tabBarController?.viewControllers?[0] as? ViewController else{return}
            if let text = myTextViewInput.text{
                if text != ""{
                    if selectedIndexRowFromViewOne != nil {
                        FVC.toDos[selectedIndexRowFromViewOne!] = text
                        selectedIndexRowFromViewOne = nil
                    }else{
                        FVC.toDos.append(text)
                    }
                    //show the lastest data
                    FVC.myTableView.reloadData()
                    //save data to local
                    UserDefaults.standard.set(FVC.toDos, forKey: "todos")
                }else{
                    if selectedIndexRowFromViewOne != nil{
                        print("\(selectedIndexRowFromViewOne!)")
                        FVC.toDos.remove(at: selectedIndexRowFromViewOne!)
                        UserDefaults.standard.set(FVC.toDos, forKey: "todos")
                        selectedIndexRowFromViewOne = nil
                        FVC.myTableView.reloadData()
                    }
                }
            }
            myTextViewInput.text = ""
            myButton.setTitle("Back", for: .normal)
            //button pressed back to the first scene
            self.tabBarController?.selectedIndex = 0
  
        
        /*
        guard let FVC = tabBarController?.viewControllers?[0] as? ViewController else{return}
        if let text = myTextInput.text{
            if text != ""{
                if selectedIndexRowFromViewOne != nil {
                    FVC.toDos[selectedIndexRowFromViewOne!] = text
                    selectedIndexRowFromViewOne = nil
                }else{
                    FVC.toDos.append(text)
                }
                    //show the lastest data
                    FVC.myTableView.reloadData()
                    //save data to local
                    UserDefaults.standard.set(FVC.toDos, forKey: "todos")
            }
        }else{
            if selectedIndexRowFromViewOne != nil{
                FVC.toDos.remove(at: selectedIndexRowFromViewOne!)
                UserDefaults.standard.set(FVC.toDos, forKey: "todos")
                selectedIndexRowFromViewOne = nil
                FVC.myTableView.reloadData()
            }
        }
        myTextInput.text = ""
        myButton.setTitle("Back", for: .normal)
        //button pressed back to the first scene
        self.tabBarController?.selectedIndex = 0
        */
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //let keyboard pop up first
        myTextViewInput.becomeFirstResponder()
        if selectedIndexRowFromViewOne != nil{
            if let FVC = tabBarController?.viewControllers?[0] as? ViewController{
                myTextViewInput.text = FVC.toDos[selectedIndexRowFromViewOne!]
                myButton.setTitle("OK", for: .normal)
            }
            // Do any additional setup after loading the view.
        }
        /*
        //make keyboard return button work
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //let "return" works as button
            textButtonPressed(UIButton())
            return true
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //should follow "UITextFieldDelegate"
        myTextViewInput.delegate = self
        myTextViewInput.becomeFirstResponder()


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
