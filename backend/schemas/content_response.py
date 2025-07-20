from pydantic import BaseModel, Field
from typing import Optional

class Content(BaseModel):
    text: str
    image: Optional[str] = Field(default=None)
