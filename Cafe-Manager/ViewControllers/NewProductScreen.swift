//
//  NewProductScreen.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import Firebase
class NewProductScreen: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var setAsItemCheck: UISwitch!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var discount: UITextField!
    
    var categories = ["Pizza","Drinks","Deserts"]
    var storage = Storage.storage()
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFoodImageTapped(_:))))
        discount.addTarget(self, action: #selector(onFinishEditingDiscount(sender:)), for: .editingDidEnd)
        
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.backgroundColor = .white
        category.inputView = categoryPicker
        category.addTarget(self, action: #selector(disableTyping(sender:)), for: .editingChanged)
        category.addTarget(self, action: #selector(enableTyping(sender:)), for: .editingDidEnd)
        category.addTarget(self, action: #selector(onCatergoryEditingBegin(sender:)), for: .editingDidBegin)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(customView: UITextView()),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onFinishSelectingCatergory(sender:))),
                          UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelCategorySelection(sender:)))
        ], animated: true)
        category.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
    }
    @objc func onFinishEditingDiscount(sender:UITextField){
        if let text = sender.text{
            let alert = AlertPopup(self)
            if let discountValue = Int(text){
                if discountValue < 0 || discountValue > 100{
                    alert.infoPop(title: "Invalid discount value", body: "Please enter a valid discount value!")
                }else{
                    return sender.text = text + " %"
                }
            }else{
                alert.infoPop(title: "Invalid Discount", body: "discount must be a number!")
            }
            sender.text = nil
        }
    }
    @objc func onCatergoryEditingBegin(sender:Any){
        if categories.count == 0{
            AlertPopup(self).infoPop(title: "No category", body: "You first need add a category first")
        }
    }
    @objc func cancelCategorySelection(sender:Any){
        category.endEditing(true)
    }
    @objc func onFinishSelectingCatergory(sender:Any){
        let selectedIndex = (category.inputView as! UIPickerView).selectedRow(inComponent: 0)
        category.text = categories[selectedIndex]
        category.endEditing(true)
    }
    @objc func disableTyping(sender:UITextField){
        sender.text = nil
        sender.isUserInteractionEnabled = false
    }
    @objc func enableTyping(sender:UITextField){
        sender.isUserInteractionEnabled = true
    }
    func captureImage(isCamera:Bool){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.sourceType = isCamera ? .camera : .photoLibrary
        imagePickerController.modalPresentationStyle = .fullScreen
        
        present(imagePickerController,animated: true)
    }
    @objc func onFoodImageTapped(_: Any){
        let prompt = UIAlertController(title: "Choose Method", message: "Choose a method to captaure image to food item", preferredStyle: .actionSheet)
        prompt.addAction(UIAlertAction(title: "By Camera", style: .default, handler: {action in
            self.captureImage(isCamera: true)
        }))
        prompt.addAction(UIAlertAction(title: "From gallery",style: .default, handler: { action in
            self.captureImage(isCamera: false)
        }))
        prompt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            prompt.dismiss(animated: true, completion: nil)
        }))
        present(prompt,animated: true)
    }
    
    //this function is called user finished selecting an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as! UIImage //retrieve the image
        foodImage.image = image
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
extension NewProductScreen : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row]
    }
    
    
}
