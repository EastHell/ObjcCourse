//
//  WallPostViewController.swift
//  CSAPITask
//
//  Created by Aleksandr on 25/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class WallPostViewController: UIViewController {

    private let ownerID: Int
    var completion: (()->())?
    
    init(ownerID: Int, completion: (()->())? = nil) {
        self.ownerID = ownerID
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.edgesToSuperview()
        textView.becomeFirstResponder()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        cancelButton.tintColor = .white
        navigationItem.leftBarButtonItem = cancelButton
        
        let sendButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        sendButton.tintColor = .white
        navigationItem.rightBarButtonItem = sendButton
        
        navigationItem.title = "Новая запись"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func cancel() {
        textView.resignFirstResponder()
        dismiss(animated: true, completion: completion)
    }
    
    @objc func add() {
        Factories.resolveWallService.wallPost(ownerID: ownerID, message: textView.text) { (result) in
            switch result {
            case .success(_):
                break
            case let .error(err):
                print("WallPostViewController.add() error occured: \(err.localizedDescription)")
            }
        }
        cancel()
    }
}
