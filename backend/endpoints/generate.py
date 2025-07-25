from fastapi import APIRouter,status, HTTPException

from ..services.content_generation_service import ContentGenerationService
from ..schemas.story_request import StoryRequest

router = APIRouter()

@router.post("/generate", status_code=status.HTTP_200_OK)
def generate_story(request: StoryRequest):
    try:
        service = ContentGenerationService()
        generated_story = service.generate_story(req=request)
        return generated_story
    except Exception as e:
        return {"status" : status.HTTP_500_INTERNAL_SERVER_ERROR, "error": str(e)}