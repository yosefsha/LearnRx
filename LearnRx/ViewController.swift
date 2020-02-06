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
    var btn2:UIButton!

    var textField:UITextField!

    var imageView:UIImageView!

    var imagObservable:Observable<DownloadableImage>?

    var bag:DisposeBag = DisposeBag()

    

    override func viewDidLoad() {

        super.viewDidLoad()

        setupButtons()

        setupTextfield()

        

    }



    func setupButtons(){

        btn = UIButton()
        btn2 = UIButton()
        
///btn1 setup
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
        
        
/// setup btn2
        btn2.addTarget(self, action: #selector(tryButtonAction), for: .touchUpInside)

         btn2.setTitle("try",for: .normal)

         btn2.titleLabel?.font = .systemFont(ofSize: 20)

        btn2.backgroundColor = .systemGreen

         btn2.setTitleColor(.black, for: .normal)



            view.addSubview(btn2)

            btn2.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([

                btn2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                btn2.topAnchor.constraint(equalTo: btn.bottomAnchor, constant:30),

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
    
    
    @objc func tryButtonAction(){

        class Tag {
            var tag: String = ""
            init (tag: String) {
                self.tag = tag
            }
        }

        let getRequestReadHTML : Observable<String> = Observable
                                    .just("<HTML><BODY>Hello world</BODY></HTML>")

        func getTagsFromHtml(htmlBody: String) -> Observable<Tag> {
            return Observable.create { obx in

                // do parsing on htmlBody as necessary
                print("obx:\(obx)")
                obx.onNext(Tag(tag: "<HTML>"))
                obx.onNext(Tag(tag: "<BODY>"))
                obx.onNext(Tag(tag: "</BODY>"))
                obx.onNext(Tag(tag: "</HTML>"))

                obx.onCompleted()

                return Disposables.create()
            }
        }

        getRequestReadHTML
            .flatMap { getTagsFromHtml(htmlBody: $0) }
            .subscribe (onNext: { e in
                print("e:\(e)")
                print(e.tag)
            })
       

    }

}



//enum DownloadableImage{

//    case content(image:Image)

//    case offlinePlaceholder

//

//}
