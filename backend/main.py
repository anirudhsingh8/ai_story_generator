import dotenv
from .core.config import Config, get_config
from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from .endpoints import generate

dotenv.load_dotenv()
config: Config = get_config()

app = FastAPI()

# Mount static files directory
app.mount("/static", StaticFiles(directory="backend/static"), name="static")

origins = [
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health", status_code=status.HTTP_200_OK)
def health_check():
    return "OK"

app.include_router(generate.router)