//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//
import SwiftUI
import SafariServices

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var isShowingSafari = false
    @State private var isFeedbackPresented = false // Feedback handling

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Image with Spacing
                if let imageUrl = recipe.photoUrlLarge {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(15)
                                .padding(.horizontal)
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Recipe Title
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                // Cuisine Type
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

             /*   // Description
                if let description = recipe.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                } else {
                    Text("Description not available.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
              */
                
                
                // Buttons Section
                VStack(spacing: 20) {
                    if let youtubeUrl = recipe.youtubeUrl {
                        Button(action: {
                            UIApplication.shared.open(youtubeUrl)
                        }) {
                            Label("Watch on YouTube", systemImage: "play.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.orange]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }

                    if let sourceUrl = recipe.sourceUrl {
                        Button(action: {
                            isShowingSafari = true
                        }) {
                            Label("Explore Full Recipe", systemImage: "globe")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        .sheet(isPresented: $isShowingSafari) {
                            SafariView(url: sourceUrl)
                        }
                    }

                    // Feedback Button
                    Button(action: {
                        isFeedbackPresented = true
                    }) {
                        Label("Submit Feedback", systemImage: "envelope")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .alert("Feedback", isPresented: $isFeedbackPresented) {
                        Button("Close", role: .cancel) {}
                    } message: {
                        Text("This is a feedback action.")
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.purple.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Safari View for External Links
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
