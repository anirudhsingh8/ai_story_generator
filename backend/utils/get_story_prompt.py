from ..schemas.story_request import StoryRequest

def get_story_prompt(req: StoryRequest) -> str:
    characters: str|int = ""
    if req.number_of_characters:
        characters = req.number_of_characters
    if req.name_of_characters:
        characters = ", ".join(req.name_of_characters) 

    prompt = (
        f"Write a story on {req.genre} genre,"
        f"consisting of {req.paragraphs} paragraphs"
        f" and {characters} characters"
    )

    return prompt