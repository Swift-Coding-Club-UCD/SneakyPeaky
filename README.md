# Sneaky Peeky 🕵️‍♂️

**Discover hidden text in your images with this playful SwiftUI OCR app powered by Apple Vision.**

---

## 🌟 Highlights

- Browse your photo library using SwiftUI’s `PhotosPicker`.  
- Leverage `VNRecognizeTextRequest` for precise text extraction.  
- Real‑time feedback: shows “Decoding…” while processing.  
- Displays extracted text in a scrollable view.  
- Clean, minimalist SwiftUI interface with concise code.

## 📝 Prerequisites

- Xcode 15 or later  
- iOS 16.0+ deployment target  
- Swift 5.7 or above

## ⚙️ Setup

1. **Clone the repository**  
   ```bash
   git clone https://github.com/yourusername/SneakyPeeky.git
   ```
2. **Open in Xcode**  
   ```bash
   cd SneakyPeeky
   open SneakyPeeky.xcodeproj
   ```
3. **Configure Signing**  
   - Select your Development Team under **Signing & Capabilities**.

## 🚀 Getting Started

1. **Build & Run** on a device or simulator.  
2. Tap **Select Photo** to open the picker.  
3. Choose any image containing text.  
4. Watch “Decoding…” and see the hidden message revealed!

## 📁 Important Files

- **`ContentView.swift`**: Main SwiftUI view with UI and OCR logic.  
- **`PhotosPicker`**: SwiftUI-native photo selector from `PhotosUI`.  
- **Vision OCR**: Powered by `VNRecognizeTextRequest` for text detection.

## ⚖️ License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
