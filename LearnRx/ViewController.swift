//  ViewController.swift

//  LearnRx

//

//  Created by Yosef Shachnovsky on 18/07/2019.

//  Copyright © 2019 Yosef Shachnovsky. All rights reserved.

//



import UIKit

import RxSwift





class ViewController: UIViewController {

    

    var btn:UIButton!

    var textField:UITextField!

    var imageView:UIImageView!

    var imagObservable:Observable<DownloadableImage>?

    var bag:DisposeBag = DisposeBag()

    

    override func viewDidLoad() {

        super.viewDidLoad()

        setupButton()

        setupTextfield()

        

    }



    func setupButton(){

        btn = UIButton()

        

        btn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)

        btn.setTitle("Button Title",for: .normal)

        btn.titleLabel?.font = .systemFont(ofSize: 20)

        btn.backgroundColor = .systemYellow

        btn.setTitleColor(.black, for: .normal)



           view.addSubview(btn)

           btn.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([

               btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

               btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),

               ])

    }

    

    func setupTextfield(){

        textField = UITextField()

        

        textField.frame = CGRect(x: 110, y: 160, width: 250, height: 30)

        textField.borderStyle = .roundedRect

        textField.placeholder = "Insert url"





           view.addSubview(textField)

           textField.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([

               textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

               textField.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 10),

               ])

    }

    

    @objc func nextButtonAction(){

        var urlstr = ""

        if let fromtextfield = textField.text, fromtextfield.isEmpty == false  {

            urlstr = fromtextfield

        } else {

            urlstr = "https://unsplash.com/photos/pAWY7xrsLwc/download?force=true"

        }

        if let reach = try? DefaultReachabilityService() {

             imagObservable = DefaultImageService.sharedImageService.imageFromURL(URL(string: urlstr)!, reachabilityService: reach)

            

            imagObservable?.subscribe(onNext: { image in

                switch image {

                case .content(let downloadedImage):

                    DispatchQueue.main.async {

                        self.imageView = UIImageView(image: downloadedImage)

                        print("did set image")

                    }

                case .offlinePlaceholder :

                    print("placeholder")

                }

                }).disposed(by: bag)



                    }

       

    }

}



//enum DownloadableImage{

//    case content(image:Image)

//    case offlinePlaceholder

//

//}
