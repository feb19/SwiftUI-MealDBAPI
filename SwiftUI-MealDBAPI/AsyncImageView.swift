//
//  AsyncImageView.swift
//  SwiftUI-MealDBAPI
//
//  Created by Nobuhiro Takahashi on 2022/05/08.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    @Binding var urlString: String?

    init(urlString: Binding<String?>) {
        self._urlString = urlString
    }

    var image: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
            } else {
                Text("No Image")
            }
        }
    }

    var body: some View {
        image.onChange(of: urlString) { newValue in
            if let urlString = urlString, let url = URL(string: urlString) {
                imageLoader.url = url
                imageLoader.load()
            }
        }
    }
}

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var url: URL?
    func load() {
        guard let url = url else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
}
