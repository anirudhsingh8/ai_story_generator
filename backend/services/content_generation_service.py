from ..core.deep_infra_llm_client import DeepInfraLLMClient
from ..core.config import get_config
from ..schemas.story_request import StoryRequest
from ..schemas.story_response import StoryResponse
from ..utils.get_story_prompt import get_story_prompt

class ContentGenerationService():
    text_generation_client: DeepInfraLLMClient

    def __init__(self):
        self.text_generation_client = DeepInfraLLMClient()


    def generate_story(self, req: StoryRequest) -> StoryResponse | None:
        config = get_config()
        prompts = []

        # Add system prompt
        prompts.append({
            "role": "system",
            "content": config.text_gen_system_prompt,
        })

        # Add user prompt
        prompts.append({
            "role": "user",
            "content": get_story_prompt(req),
        })

        story_str = self.text_generation_client.generate_text(messages=prompts)
        return StoryResponse.model_validate_json(story_str)
