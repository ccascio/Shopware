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
class EditAttributeView: UIViewController {

    var attribute: String?
    @IBOutlet weak var editTitle: UILabel!
    @IBOutlet weak var textField: UITextView!

    init(attribute: String) {
        super.init(nibName: "EditAttributeView", bundle: nil)
        self.attribute = attribute
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        switch attribute {
        case "bio":
            editTitle.text = "About you"
            textField.text = StoreStruct.profile.bio
        case "mail":
            editTitle.text = "Your email"
            textField.text = StoreStruct.profile.email
        case "username":
            editTitle.text = "Username"
            textField.text = StoreStruct.profile.username
        case "mobile":
            editTitle.text = "Mobile phone"
            textField.text = StoreStruct.profile.phone
        default:
            editTitle.text = "Oops"
            textField.text = ""
            break
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func done(_ sender: UIButton) {

        switch attribute {
        case "bio":
            editTitle.text = "About you"
            StoreStruct.profile.bio = textField.text
        case "mail":
            editTitle.text = "Your email"
            StoreStruct.profile.email = textField.text
        case "username":
            editTitle.text = "Username"
            StoreStruct.profile.username = textField.text
        case "mobile":
            editTitle.text = "Mobile phone"
            StoreStruct.profile.phone = textField.text
        default:
            break
        }
        
        print(#function)
        dismiss(animated: true, completion: {
            CloudController().saveProfile()
        })
    }
}
