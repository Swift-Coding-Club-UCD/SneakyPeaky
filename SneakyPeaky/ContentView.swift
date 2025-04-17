//
//  ContentView.swift
//  SneakyPeaky
//
//  Created by Mark Le on 4/17/25.
//

import SwiftUI
import Vision

struct ContentView: View {
    @State private var image: UIImage?
    @State private var recognizedText = ""
    @State private var showPicker = false
    @State private var useCamera = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.2))
                        .frame(height: 300)
                        .overlay(Text("No Image Selected").foregroundColor(.secondary))
                        .cornerRadius(8)
                }

                Button("Select Photo") {
                    useCamera = false
                    showPicker = true
                }
                Button("Take Photo") {
                    useCamera = true
                    showPicker = true
                }

                ScrollView {
                    Text(recognizedText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(maxHeight: 200)

                Spacer()
            }
            .padding()
            .navigationTitle("Secret Decoder")
            .sheet(isPresented: $showPicker) {
                ImagePicker(sourceType: useCamera ? .camera : .library) { img in
                    self.image = img
                    recognizeText(in: img)
                }
            }
        }
    }

    func recognizeText(in image: UIImage) {
        recognizedText = "Decoding…"
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest { req, err in
            guard let results = req.results as? [VNRecognizedTextObservation],
                  err == nil else {
                DispatchQueue.main.async { recognizedText = "Recognition failed." }
                return
            }
            let lines = results.compactMap { obs in
                obs.topCandidates(1).first?.string
            }
            DispatchQueue.main.async {
                recognizedText = lines.joined(separator: "\n")
            }
        }
        request.recognitionLevel = .accurate
        // request.recognitionLanguages = ["en-US", "es"]  // multi‑lang

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}

// MARK: - ImagePicker
struct ImagePicker: UIViewControllerRepresentable {
    enum Source { case camera, library }
    var sourceType: UIImagePickerController.SourceType
    var completion: (UIImage) -> Void

    init(sourceType: Source, completion: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType == .camera ? .camera : .photoLibrary
        self.completion = completion
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiVC: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            if let img = info[.originalImage] as? UIImage {
                parent.completion(img)
            }
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
#Preview {
    ContentView()
}
