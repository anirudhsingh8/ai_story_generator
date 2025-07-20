import dotenv
from .core.config import Config, get_config
from fastapi import FastAPI, status
from .endpoints import generate

dotenv.load_dotenv()
config: Config = get_config()

app = FastAPI()

@app.get("/health", status_code=status.HTTP_200_OK)
def health_check():
    return "OK"

app.include_router(generate.router)