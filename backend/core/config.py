import os
from functools import lru_cache

class Config:
    deepinfra_base_url: str
    deepinfra_api_key: str
    model: str

    def __init__(self):
        self.deepinfra_base_url = os.getenv("DEEPINFRA_BASE_URL")
        self.deepinfra_api_key = os.getenv("DEEPINFRA_API_KEY")
        self.model = os.getenv("MODEL")
        print("Config updated successfully!")

@lru_cache
def get_config():
    return Config()