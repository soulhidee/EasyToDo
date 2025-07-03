import UIKit

final class ProfileImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Constants
    enum ProfileImagePickerConstants {
        static let alertTitle = "Выберите источник"
        static let alertActionCamera = "Камера"
        static let alertActionPhotoLibrary = "Галерея"
        static let alertActionCancel = "Отмена"
    }
    
    var profileImagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        
        let alert = UIAlertController(title: ProfileImagePickerConstants.alertTitle, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: ProfileImagePickerConstants.alertActionCamera, style: .default) { _ in
                self.presentPicker(in: viewController, sourceType: .camera)
            })
        }
        
        alert.addAction(UIAlertAction(title: ProfileImagePickerConstants.alertActionPhotoLibrary, style: .default) { _ in
            self.presentPicker(in: viewController, sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: ProfileImagePickerConstants.alertActionCancel, style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    
    private func presentPicker(in viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        profileImagePickerController = UIImagePickerController()
        profileImagePickerController?.delegate = self
        profileImagePickerController?.sourceType = sourceType
        guard let picker = profileImagePickerController else { return }
        viewController.present(picker, animated: true)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
