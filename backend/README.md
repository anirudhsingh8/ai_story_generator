# AI Story Generator - Backend

A FastAPI backend service that generates stories and accompanying images using Deep Infra's LLM API.

## Architecture

The backend follows a layered architecture:

- **Endpoints**: API routes for generating stories
- **Services**: Business logic for story and image generation
- **Schemas**: Pydantic data models for request/response validation
- **Core**: Configuration and external service clients
- **Utils**: Helper functions for text processing and file handling

## Environment Variables

Create a `.env` file in the backend directory with the following variables:

```
DEEPINFRA_BASE_URL=https://api.deepinfra.com/v1/openai
DEEPINFRA_API_KEY=your_deepinfra_api_key
TEXT_MODEL=your_text_model_name
IMAGE_MODEL=your_image_model_name
```

## Setup & Running

1. Install dependencies:

```bash
cd backend
pip install -r requirements.txt
```

2. Run the server:

```bash
uvicorn backend.main:app --reload
```

The server will start on http://localhost:8000.

## API Endpoints

- **GET /health**: Health check endpoint
- **POST /generate**: Generate a story based on input parameters

### Generate Story Request

```json
{
  "genre": "fantasy",
  "number_of_characters": 2,
  "name_of_characters": ["Alice", "Bob"],
  "paragraphs": 3,
  "generate_images": true
}
```

All generated images are stored in the `backend/static` directory and served via the `/static` endpoint.
