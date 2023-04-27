//
//  SecondViewController.swift
//  ReactorKitPractice
//
//  Created by 유지호 on 2023/04/27.
//

import UIKit

class SecondViewController: UIViewController {

    private var helloLabel = UILabel().then {
        $0.text = "안녕하세요 !"
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(helloLabel)
        
        helloLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
