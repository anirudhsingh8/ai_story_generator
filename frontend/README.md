# AI Story Generator - Frontend

A Flutter application that provides a user interface for generating and viewing AI-created stories with optional images.

## Architecture

The frontend follows a BLoC pattern architecture:

- **Models**: Data classes for API requests and responses
- **Services**: API communication and data fetching
- **Bloc**: State management for story generation process
- **Pages**: UI screens for story form input and results display
- **Widgets**: Reusable UI components

## Environment Variables

Create a `.env` file in the frontend directory with:

```
API_BASE_URL=http://localhost:8000
```

## Setup & Running

1. Install dependencies:

```bash
cd frontend
make setup
```

2. Run code generation for JSON serialization:

```bash
cd frontend
make generate_models
```

3. Run the app:

```bash
cd frontend
make run
```

## Building for Production

```bash
flutter build web
```

The compiled app will be available in the `build/web` directory.
