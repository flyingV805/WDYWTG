# WDYWTG

### Where do you want to go?

WDYWTG is a mobile app built with Flutter that helps users prepare for their trip by providing current weather information and personalized clothing and footwear recommendations based on the destination.

## 🧭 Features

- 🌤 Get weather forecasts for any location and date.
- 💸 Get tips on preparing cash for a new place.
- 🤝 Get tips on cultural differences.
- 🧥 Recommendations on what to wear and which shoes to take based on weather conditions.
- 🧳 Plan trips ahead of time (planned).
- 📍 Location and map integration.
- 💬 Multilingual support (planned).

## 📱 Screenshots

*TBA*

## 🚀 Getting Started

Make sure you have Flutter installed and set up properly.

1. Clone the repository:
   ```bash
   git clone https://github.com/flyingV805/WDYWTG
   cd wdywtg
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run `build_runner`:
   ```bash
   dart run build_runner build
   ```
4. Add the .env file to the root of the project and add the following parameters to it:
   ```bash
   OPEN_CAGE_API_KEY=<>
   UNSPLASH_API_ACCESS_KEY=<>
   ```
5. Setup Firebase (https://firebase.flutter.dev/docs/overview/) and enable Vertex AI in Firebase Console:

6. Run the app:
   ```bash
   flutter run
   ```

## 🧩 Technologies Used
### Flutter — UI toolkit
### Dart — programming language
### OpenWeatherMap API — weather data provider
### OpenCage Geocoding API — weather data provider
### Geolocator — for location services
### BLoC — state management

## 📌 Roadmap
📅 Multi-day weather forecast  ✅

🧳 Smart packing list based on weather

☁️ Cloud sync (Google/Apple accounts)

🧠 ML-powered personalized suggestions  ✅
