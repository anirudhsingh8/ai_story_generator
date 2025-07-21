.PHONY: run clean build

# Run the Flutter app in development mode
run:
	flutter run -d chrome --web-port=8080

# Clean the project
clean:
	flutter clean
	flutter pub get

# Generate models from json
generate_models:
	flutter pub run build_runner build --delete-conflicting-outputs

# Install dependencies
setup:
	flutter pub get
