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
import Kingfisher

//-------------------------------------------------------------------------------------------------------------------------------------------------
extension UIImage {

    var highestQualityJPEGNSData: NSData { return self.jpegData(compressionQuality: 1.0)! as NSData }
    var highQualityJPEGNSData: NSData    { return self.jpegData(compressionQuality: 0.75)! as NSData}
    var mediumQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.5)! as NSData }
    var lowQualityJPEGNSData: NSData     { return self.jpegData(compressionQuality: 0.25)! as NSData}
    var lowestQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.0)! as NSData }
    
    func imageFromUrl(url: String) {

        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self? = image
            }
        }.resume()
    }

    func imageFromCloudkit(table: String, column: String, id: String, isPrivate: Bool) {

        CloudController().queryPhoto(tableName: table, column: column, id: id, isPrivate: isPrivate) { photo in
            if photo != nil {
                DispatchQueue.main.async() { [weak self] in
                    self? = photo!
                }
            } else {
                DispatchQueue.main.async() { [weak self] in
                    self? = UIImage(systemName: "person.fill")!
                }
            }
        }
    }

    public func maskWithColor(color: UIColor) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        let rect = CGRect(origin: CGPoint.zero, size: size)

        color.setFill()
        self.draw(in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension UIImageView {

    func sample(_ topic: String, _ subtopic: String, _ index: Int) {

        KingfisherManager.shared.downloader.downloadTimeout = 600
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        let options: KingfisherOptionsInfo = [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.5)), .downloadPriority(1.0)]

        let url = URL(string: String(format: "https://relatedcode.com/pics/\(topic)/\(subtopic)/%02d.jpg", index+1))

        let size = CGSize(width: 1, height: 1)
        let placeholder = UIGraphicsImageRenderer(size: size).image { rendererContext in
            UIColor.lightGray.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }

        self.kf.setImage(with: url, placeholder: placeholder, options: options)
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func imageFromUrl(_ topic: String, _ subtopic: String, _ index: Int) {

		KingfisherManager.shared.downloader.downloadTimeout = 600
		let processor = DownsamplingImageProcessor(size: self.frame.size)
		let options: KingfisherOptionsInfo = [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.5)), .downloadPriority(1.0)]

		let url = URL(string: String(format: "https://relatedcode.com/pics/\(topic)/\(subtopic)/%02d.jpg", index+1))

		let size = CGSize(width: 1, height: 1)
		let placeholder = UIGraphicsImageRenderer(size: size).image { rendererContext in
			UIColor.lightGray.setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}

		self.kf.setImage(with: url, placeholder: placeholder, options: options)
	}

    func imageFromUrl(url: String) {

        KingfisherManager.shared.downloader.downloadTimeout = 600
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        let options: KingfisherOptionsInfo = [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.5)), .downloadPriority(1.0)]

        let url = URL(string: String(format: url))

        let size = CGSize(width: 1, height: 1)
        let placeholder = UIGraphicsImageRenderer(size: size).image { rendererContext in
            UIColor.lightGray.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }

        self.kf.setImage(with: url, placeholder: placeholder, options: options)
    }

    func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{

        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!

        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)

        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]

        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))

        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)

        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)

        // Create a new image out of the images we have created
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return .init() }

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()

        //Pass the image back up to the caller
        return newImage

    }
}
