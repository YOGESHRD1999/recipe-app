# RecipeApp

RecipeApp is a modern iOS application built with SwiftUI and Swift Concurrency to provide a seamless recipe browsing experience. It connects to a remote API to fetch recipes and elegantly handles various scenarios, including malformed and empty data.

---

## Summary

RecipeApp dynamically displays a list of recipes, allowing users to explore various cuisines. It ensures an efficient user experience by implementing on-demand image loading and error handling.

### Key Features

1. **Dynamic Recipe List**  
   - Displays recipes with their name, cuisine type, and thumbnail image.  
   - Supports pull-to-refresh functionality to fetch the latest recipes.  

2. **Error Handling**  
   - Gracefully handles malformed and empty data scenarios.  
   - Displays user-friendly messages for API errors.  

3. **Custom Image Caching**  
   - Reduces network usage with a lightweight caching mechanism for images.  
   - Ensures smooth scrolling and optimized performance.  

4. **Search Functionality**  
   - Allows users to search recipes by name, cuisine, or description.  

5. **Empty State Display**  
   - Notifies users when no recipes are available.  

---

### Screenshots

1. **Recipe List**  
   - Displays recipes with essential details.  
   - Includes a search bar for easy navigation.
   - Handles errors gracefully with user-friendly messages.
   - Shows a friendly message when no recipes are available.

Here is an example screenshot of the Recipe App:
### Screenshots

#### App Icon
<img src="https://github.com/user-attachments/assets/6c623181-d3b6-4edb-97f4-16a1460da1f3" alt="APP Icon" width="150"/>

#### 1. Welcome Screen
<img src="https://github.com/user-attachments/assets/d7842a33-f67e-4dfe-9914-2389924adf10" alt="Welcome Screen" width="200"/>

#### 2. Recipe List Screen
<img src="https://github.com/user-attachments/assets/8da54f1d-1b89-45a8-9d6b-c00da52282d2" alt="Recipe List" width="200"/>

#### 3. Search Feature
<img src="https://github.com/user-attachments/assets/cee17c48-a539-4600-b10e-57ed9f80b480" alt="Search Screen - Apam Balik" width="200"/>

#### 4. Search Specific Result
<img src="https://github.com/user-attachments/assets/2702caac-03cc-4812-ad32-a596618a02d6" alt="Search Screen - Balik" width="200"/>

#### 5. Filter by Cuisine
<img src="https://github.com/user-attachments/assets/8d8f089d-5dc8-4fb2-8e4b-7344bb6f0528" alt="Search Screen - Malaysian Cuisine" width="200"/>

#### 6. No Results Found
<img src="https://github.com/user-attachments/assets/56e61d6f-19f2-4901-8881-d100f6ac856b" alt="Empty State Screen" width="200"/>

#### 7. Recipe Detail Screen
<img src="https://github.com/user-attachments/assets/3233e88d-1ea4-4e10-8d26-caca7b598461" alt="Recipe Detail Screen" width="200"/>

#### 8. External Recipe Link
<img src="https://github.com/user-attachments/assets/fbcbd096-084d-4e95-bb51-8744d5b8313e" alt="External Recipe Link" width="200"/>

#### 9. Feedback Action
<img src="https://github.com/user-attachments/assets/dcd5a4db-e1af-4d61-aae9-9f50fe61ae08" alt="Feedback Popup" width="200"/>

#### 10. Video Recipe
<img src="https://github.com/user-attachments/assets/ac6d45cc-bd34-4885-91b9-c6464611b748" alt="Video Screen" width="200"/>


#### Final RecipeApp Video

[<img src="https://github.com/user-attachments/assets/c8315403-0d90-45dc-8ab5-96b8d83c546e" alt="Video Screen" width="200"/>](https://github.com/user-attachments/assets/c8315403-0d90-45dc-8ab5-96b8d83c546e)
---

## Focus Areas

1. **Core Functionality**  
   - Displaying recipes with essential details: name, cuisine type, and image.  
   - Implementing seamless pull-to-refresh functionality.  
   - Handling empty or malformed data gracefully.  

2. **Performance Optimization**  
   - Leveraged Swift Concurrency (async/await) for efficient, non-blocking API calls.  
   - Implemented custom caching for images to minimize repeated network requests and enhance scrolling performance.  

3. **Testing**  
   - Focused on unit testing for core features like data fetching, image caching, and error handling.  
   - Ensured robust error handling with simulated scenarios for malformed and empty data.  

---

### API Details

The following JSON endpoints provide the data for this project:

1. **All Recipes**  
   - Endpoint: https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json  
   - Provides a list of all recipes, including details like cuisine type, name, and image URLs.  

2. **Malformed Data**  
   - Endpoint: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json  
   - Simulates a scenario where the recipe data is malformed. The app is designed to handle this gracefully by displaying an error message.  

3. **Empty Data**  
   - Endpoint: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json  
   - Simulates a scenario where no recipes are available. The app displays an empty state message in such cases.  

---

### Trade-offs and Decisions

1. **Custom Image Caching**  
   - **Trade-off:** Manually implementing caching added development time.  
   - **Decision:** Avoided third-party libraries to meet the requirement and maintain full control over the caching behavior.  

2. **Single-Screen Design**  
   - **Trade-off:** Limited to one screen to focus on core functionality.  
   - **Decision:** Prioritized simplicity and clarity, ensuring the main features are polished.  

3. **No External Libraries**  
   - **Trade-off:** Required writing custom networking and caching logic.  
   - **Decision:** Met the project requirement and ensured a lightweight implementation.  

---

### Weakest Part of the Project

- **Limited UI Customization:**  
  - Currently, the app offers basic UI design. More advanced animations or themes could enhance the visual appeal.  

- **Search Functionality:**  
  - The search bar provides basic filtering but could be expanded with advanced filters (e.g., ingredient-based search or preparation time).  

---

### Future Enhancements

1. **User Authentication**  
   - Add login and registration features for personalized recipe suggestions.  

2. **Offline Support**  
   - Cache recipes locally to allow browsing without an internet connection.  

3. **Advanced Filtering**  
   - Include filters for dietary preferences, cooking time, and difficulty level.  

4. **Social Features**  
   - Allow users to save recipes, share them with friends, and add reviews.  

5. **In-App Purchases**  
   - Offer premium features like exclusive recipes, an ad-free experience, or meal-planning tools.  

6. **Video Integration**  
   - Include embedded cooking videos for step-by-step guidance.  

7. **Ads Integration**  
   - Use AdMob or other platforms to monetize the app while maintaining user experience.  

---

### Time Spent

- **Total Time:** ~7 hours  
  - Core Features Development: ~3 hours  
  - Performance Optimization: ~1 hour  
  - Testing and Debugging: ~2 hours  
  - Documentation: ~1 hour  

---

### Challenges and Lessons Learned

1. **Efficient Caching:**  
   - **Challenge:** Implementing a custom image caching solution without third-party libraries.  
   - **Lesson:** Gained insights into managing memory and disk storage effectively.  

2. **Error Handling:**  
   - **Challenge:** Handling diverse error scenarios like malformed and empty data.  
   - **Lesson:** Improved skills in designing user-friendly fallback mechanisms.  

---

### How to Run

1. Clone the repository:  
   ```bash
   git clone https://github.com/username/RecipeApp.git
   ```  

2. Open the project in Xcode 14.0+.  

3. Run the app on a simulator or an iOS 16+ device.  

---

### Minimum Requirements

- **iOS Version:** iOS 16+  
- **Xcode Version:** Xcode 14+  

---

### Contact

For feedback or inquiries, feel free to reach out:  
- **Email:** dholakiyayogesh5128@gmail.com  
