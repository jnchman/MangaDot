//
//  TitleViewModel.swift
//  Manga
//
//  Created by Jian Chao Man on 27/9/18.
//  Copyright © 2018 Jian Chao Man. All rights reserved.
//

import Foundation

class TitleViewModel {
    // MARK: - Types

    enum TitleDataError: Error {
        case noTitleDataAvailable
    }

    // MARK: - Type Aliases

    typealias DidFetchTitleDataCompletion = (DetailedTitleData?, TitleDataError?) -> Void

    // MARK: - Properties

    var didfetchTitleData: DidFetchTitleDataCompletion?
    var titleId: Int

    init(titleId: Int) {
        self.titleId = titleId
    }

    func fetchMangadexTitleData() {
        fetchMangadexTitleData(id: titleId)
    }

    private func fetchMangadexTitleData(id: Int) {
        let mangadexRequest = MangadexApiRequest(baseUrl: MangadexService.baseApiUrl, type: MangadexService.ApiType.title, id: String(id))
        var request = URLRequest(url: mangadexRequest.url)
        request.setValue("Accept-Encoding", forHTTPHeaderField: "compress, gzip")
        // Create Data Task
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Manga Data \(error)")
                    self?.didfetchTitleData?(nil, .noTitleDataAvailable)
                } else if let data = data {
                    // Initilise JSON Decoder
                    let decoder = JSONDecoder()

                    // Configure JSON Decoder
                    decoder.dateDecodingStrategy = .secondsSince1970
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    do {
                        // Decode JSON Response
                        let mangadexTitleResponse = try decoder.decode(MangadexTitleResponse.self, from: data)

                        // Invoke Completion Handler
                        self?.didfetchTitleData?(mangadexTitleResponse, nil)
                    } catch {
                        print("Unable to Decode JSON Response \(error)")

                        // Invoke Completion Handeler
                        self?.didfetchTitleData?(nil, .noTitleDataAvailable)
                    }
                } else {
                    self?.didfetchTitleData?(nil, .noTitleDataAvailable)
                }
            }
        }.resume()
    }
}