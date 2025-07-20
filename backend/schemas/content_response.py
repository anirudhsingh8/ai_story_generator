from pydantic import BaseModel, Field
from typing import Optional

class Content(BaseModel):
    text: str
    image_prompt: Optional[str] = Field(default=None)
    image_path: Optional[str] = Field(default=None)
