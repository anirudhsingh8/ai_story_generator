from pydantic import BaseModel
from .content_response import Content

class StoryResponse(BaseModel):
    summary: str
    contents: list[Content]

