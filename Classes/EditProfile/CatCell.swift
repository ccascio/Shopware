
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
class CatCell: UITableViewCell {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var check: UIImageView!

    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func bindData(index: Int, data: Category) {

        catName.text = data.name
        check.isHighlighted = data.checked
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width  // get 80% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space

            super.frame = frame

        }
    }
}

