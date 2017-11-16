//
//  ViewController.swift
//  Announcement
//
//  Created by Mayu on 16/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import UIKit




class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    static let cellIdentifier = "cellIdentifier"
    let url = "http://www.solutions4mobility.com/AABToyota/ipdp/ipdpb.ashx?CFG=OPTIMAL&p=Common.Announcements&Handler=News&MODULE_ID=501&TemplateName=News.htm&APPLICATION_NAME=TOYOTA&F=J"
    @IBOutlet weak var tv: UITableView!
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    
    override func viewDidLoad() {
        
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.center = view.center;
        activityIndicator.activityIndicatorViewStyle = .gray
        
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self

        self.webserviceCall()
        
        self.tv.addSubview(activityIndicator)
    }
    
    func webserviceCall(){
        activityIndicator.startAnimating()
        DataManager.shared.loadData(url: url, successHandler: { [unowned self] json in
            DispatchQueue.main.async {
                self.tv.reloadData()
               self.activityIndicator.stopAnimating()

            }

        }) { error in
            print(error.localizedDescription)
        }
    }

 
   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.annoucementList == nil{
            return 0
        }
        return DataManager.shared.annoucementList!.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: ViewController.cellIdentifier)
        }
        cell!.textLabel?.text = DataManager.shared.annoucementList![indexPath.row].title ?? "Unknown"
        cell!.detailTextLabel?.text = DataManager.shared.annoucementList![indexPath.row].date ?? "Unknown"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DataManager.shared.selectedAnnoucement =  DataManager.shared.annoucementList![indexPath.row]
        
        let vc : WebviewController = self.navigationController!.storyboard!.instantiateViewController(withIdentifier: "webview") as! WebviewController;
        self.navigationController!.pushViewController(vc, animated: true)
            }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

