//
//  ViewController.swift
//  CafeMap
//
//  Created by guowei on 2020/8/12.
//  Copyright © 2020 guowei. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    
    var cafes=[CafeInfo]()
    
    var pickerView=UIPickerView()//實例建立Pickerview
    
    let cities=["taipei","yilan","taoyuan","hsinchu","miaoli","taichung","changhua","Nantou","Yunlin","Chiayi","Tainan","Kaohsiung","Pingtung"]
    
    
    let apiUrlString="https://cafenomad.tw/api/v1.2/cafes" //原來API網址
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設定 UIPickerView 的 delegate 及 dataSource
        pickerView.delegate=self
        pickerView.dataSource=self
        
        //設定textField彈出為pickerView
        textField.inputView=pickerView
        textField.textAlignment = .center
        textField.placeholder="Select a City"
        
        
        //註冊cell使用自訂的xib
        let nib=UINib(nibName:"CafeTableViewCell", bundle: nil)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.register(nib,forCellReuseIdentifier:"CafeTableViewCell")
        
        
    }
    
    @IBAction func searchCity(_ sender: Any) {
        
        if let searchText=textField.text {
            
            let urlString="\(apiUrlString)/\(searchText)"//查詢城市的URL
            
            if let url=URL(string: urlString){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    let decoder=JSONDecoder() //使用JSONDecoder的方式將抓到的資料轉換成剛剛定義好的CafeInfo型別
                    
                    if let data=data,let cafeResult=try?decoder.decode([CafeInfo].self, from: data){
                        self.cafes=cafeResult
                        print(cafeResult)
                        print(self.cafes.count)
                        
                        DispatchQueue.main.async {
                            self.tableview.reloadData()//Tableview更新抓到的資料
                        }
                    }
                }.resume()
            }
        }
    }

}

//TableViewController
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count //回傳列數
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier:"CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        
        let cafeInfo=cafes[indexPath.row]
        
        cell.cafeName.text=cafeInfo.name
        
        cell.cafeAddress.text=cafeInfo.address
       
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showDetail"{
            if let indexpath=tableview.indexPathForSelectedRow {
                let vc=segue.destination as! DetailViewController
                vc.cafeData=cafes[indexpath.row]
            }
        }
    }
   

}

//PickerViewController
extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    //// UIPickerView 有幾列可以選擇 這邊為1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //實作的方法
    // UIPickerView 各列有多少行資料資料為cities的數量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    //顯示資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //將pickerView選的資料放入textfield中
        textField.text=cities[row]
        //結束選擇
        textField.resignFirstResponder()
        
    }
    
    
}
