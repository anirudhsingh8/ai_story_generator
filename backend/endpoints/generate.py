from fastapi import APIRouter,status, HTTPException
from ..schemas.story_response import StoryResponse
from ..schemas.story_request import StoryRequest

router = APIRouter()

@router.post("/generate")
def generate_story(request: StoryRequest):
    return {"code": "OK"}