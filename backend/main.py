import dotenv
from .core.config import Config, get_config
from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from .endpoints import generate

dotenv.load_dotenv()
config: Config = get_config()

app = FastAPI()

origins = [
    "*",
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