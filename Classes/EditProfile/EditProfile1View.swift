//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
class EditProfile1View: UIViewController, UITextFieldDelegate {

    var fdTakeController = FDTakeController()
    let cf = CommonFunctions()
    var loginView: Login3View!
    var fullname: PersonNameComponents?
	@IBOutlet var tableView: UITableView!

	@IBOutlet var cellName: UITableViewCell!
	@IBOutlet var cellBio: UITableViewCell!
	@IBOutlet var cellMobilePhone: UITableViewCell!
	@IBOutlet var cellUsername: UITableViewCell!
	@IBOutlet var cellEmail: UITableViewCell!
	@IBOutlet var cellLogout: UITableViewCell!

	@IBOutlet var imageProfile: UIImageView!
	@IBOutlet var lastnameTextField: UITextField!
    @IBOutlet var firstnameTextField: UITextField!

	@IBOutlet var labelBio: UILabel!
	@IBOutlet var labelMobilePhone: UILabel!
	@IBOutlet var labelUsername: UILabel!
	@IBOutlet var labelEmail: UILabel!

    @IBAction func editFieldName(_ sender: UITextField) {
        self.view.endEditing(true)
        StoreStruct.profile.lastname = lastnameTextField.text?.trimmingCharacters(in: .whitespaces)
        self.view.endEditing(true)
    }
    @IBAction func editFieldName1(_ sender: UITextField) {
        self.view.endEditing(true)
        StoreStruct.profile.firstname = firstnameTextField.text?.trimmingCharacters(in: .whitespaces)
        self.view.endEditing(true)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Edit Profile"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
        self.lastnameTextField.delegate = self
        self.firstnameTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(actionDone(_:)))

		tableView.register(UINib(nibName: "CatCell", bundle: Bundle.main), forCellReuseIdentifier: "CatCell")
        //Looks for single or multiple taps.
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
//        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
		loadData()
	}


	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

        if StoreStruct.profile.lastname != "" {
            lastnameTextField.text = StoreStruct.profile.lastname!
        }
        if StoreStruct.profile.firstname != "" {
            firstnameTextField.text = StoreStruct.profile.firstname!
        }

        if StoreStruct.profile.phone != nil {
            self.labelMobilePhone.text = StoreStruct.profile.phone
        }

        if StoreStruct.profile.bio == nil || StoreStruct.profile.bio == "" {
            labelBio.text = "50 words about you"
        } else {
            labelBio.text = StoreStruct.profile.bio!
        }

        if StoreStruct.profile.username == nil || StoreStruct.profile.username == "" {
            labelUsername.text = "username"
        } else {
            labelUsername.text = StoreStruct.profile.username!
        }

        if StoreStruct.profile.email == nil || StoreStruct.profile.email == "" {
            labelEmail.text = "your@mail.com"
        } else {
            labelEmail.text = StoreStruct.profile.email!
        }

        if StoreStruct.profile.photo == nil {
            imageProfile.image = UIImage(systemName: "person.fill")
        } else {
            imageProfile.image = StoreStruct.profile.photo 
        }
	}


	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDone(_ sender: UIButton) {
        CloudController().saveProfile()
		print(#function)
        navigationController?.popViewController(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionChangePhoto(_ sender: UIButton) {

        resetFDTakeController()
        fdTakeController.presentingView = sender
        fdTakeController.present()
		print(#function)
	}

    private func resetFDTakeController () -> Void {

        fdTakeController.didDeny = {
            let alert = UIAlertController(title: "Denied", message: "User did not select a photo/video", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fdTakeController.didCancel = {

        }
        fdTakeController.didFail = {
            let alert = UIAlertController(title: "Failed", message: "User selected but API failed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fdTakeController.didGetPhoto = {
            (photo: UIImage, info: [AnyHashable : Any]) -> Void in

            StoreStruct.profile.photo = CommonFunctions().resizeImage(image: photo, targetSize: CGSize(width: 1300, height: 1300))
            self.imageProfile.image = StoreStruct.profile.photo

            if StoreStruct.profile.id != nil {
                CloudController().savePhoto(record: StoreStruct.profile.record! , photoColumn: "photo", photo: StoreStruct.profile.photo!, isPrivate: true) { _ in }
            }
        }
    }
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension EditProfile1View: UITableViewDataSource {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 5
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 1 }
		if (section == 1) { return 1 }
		if (section == 2) { return 3 }
        if (section == 3) { return StoreStruct.categories.count }
        if (section == 4) { return 1 }
		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellName			}

		if (indexPath.section == 1) && (indexPath.row == 0) { return cellBio			}

		if (indexPath.section == 2) && (indexPath.row == 0) { return cellMobilePhone	}
		if (indexPath.section == 2) && (indexPath.row == 1) { return cellUsername		}
		if (indexPath.section == 2) && (indexPath.row == 2) { return cellEmail			}

		if (indexPath.section == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
            cell.bindData(index: indexPath.item, data: StoreStruct.categories[indexPath.row])
            return cell
        }

        if (indexPath.section == 4) && (indexPath.row == 0) { return cellLogout            }

		return UITableViewCell()
	}
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension EditProfile1View: UITableViewDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("didSelectItemAt \(tableView) \(indexPath.row)")

        if (indexPath.section == 1) && (indexPath.row == 0) {
            let editText = EditAttributeView(attribute: "bio")
            self.present(editText, animated: true)
        }

        if (indexPath.section == 2) && (indexPath.row == 0) {
            let editText = EditAttributeView(attribute: "mobile")
            self.present(editText, animated: true)
        }
        if (indexPath.section == 2) && (indexPath.row == 1) {
            let editText = EditAttributeView(attribute: "username")
            self.present(editText, animated: true)
        }
        if (indexPath.section == 2) && (indexPath.row == 2) {
            let editText = EditAttributeView(attribute: "mail")
            self.present(editText, animated: true)
        }

        if (indexPath.section == 3) {
            StoreStruct.categories[indexPath.row].checked.toggle()
            CloudController().saveCategories(publicRepo: false)
            if !StoreStruct.categories[indexPath.row].checked {
                StoreStruct.categories[indexPath.row].record = nil
            }
            DispatchQueue.main.async {
                StoreStruct.categories.sort { $0.sort < $1.sort }
                self.tableView.reloadData()
            }
        }

        if (indexPath.section == 4) && (indexPath.row == 0) {
            do {
                try KeychainItem(service: "com.cascio.social", account: "userIdentifier").deleteItem()
                CloudController().deleteProfile()
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }

            let login = Login3View()
            self.present(login, animated: true)
        }
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		if (indexPath.section == 0) { return 120 }
		return 45
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

		if (section == 0) { return 0.01 }
		if (section == 1) { return 10 }
		if (section == 2) { return 55 }
        if (section == 3) { return 55 }
        if (section == 4) { return 55 }
		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		if (section == 1) { return "" 	}
		if (section == 2) { return "Contact"	}
        if (section == 3) { return "Categories"    }
        if (section == 4) { return "Session"    }

		return ""
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

		if let header = view as? UITableViewHeaderFooterView {
			header.contentView.backgroundColor = .tertiarySystemFill
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

		return 0.01
	}
}
