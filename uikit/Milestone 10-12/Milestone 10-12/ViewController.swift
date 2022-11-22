//
//  ViewController.swift
//  Milestone 10-12
//
//  Created by Clément Villanueva on 08/08/2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pictures"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        
        /*
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                print("Failed to load pictures.")
            }
        }
         */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.pictureName = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addPicture() {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegdata = image.jpegData(compressionQuality: 1.0) {
            try? jpegdata.write(to: imagePath)
        } else {
            print("Failed to write the picture.")
        }
        
        dismiss(animated: true)
        
        /*
        var caption = ""
                
        let ac = UIAlertController(title: "Add a caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let text = ac.textFields![0].text {
                caption = text
            } else {
                print("Can't set caption.")
            }
        })
        
        present(ac, animated: true)
         */
        
        pictures.append(imageName)
        
        tableView.reloadData()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedPictures = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedPictures, forKey: "pictures")
        } else {
            print("Failed to save pictures.")
        }
    }
    
}

