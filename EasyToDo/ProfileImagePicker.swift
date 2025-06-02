import UIKit

final class ProfileImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var profileImagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        profileImagePickerController = UIImagePickerController()
        profileImagePickerController?.delegate = self
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
