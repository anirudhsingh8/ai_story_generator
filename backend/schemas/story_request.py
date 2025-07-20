from pydantic import BaseModel, Field
from typing import Optional

class StoryRequest(BaseModel):
    genre: str = Field(..., min_length=3)
    number_of_characters: Optional[int] = Field(default=None, gt=0)
    name_of_characters: Optional[list[str]] = Field(default=None)
    paragraphs: int = Field(default=1)
    generate_images: bool = Field(default=False)