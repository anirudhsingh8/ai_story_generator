from ..core.deep_infra_llm_client import DeepInfraLLMClient
from ..core.config import get_config
from ..schemas.story_request import StoryRequest
from ..schemas.story_response import StoryResponse
from ..utils.get_story_prompt import get_story_prompt

class ContentGenerationService():
    llm_client: DeepInfraLLMClient

    def __init__(self):
        self.llm_client = DeepInfraLLMClient()


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

        story_str = self.llm_client.generate_text(messages=prompts)
        model = StoryResponse.model_validate_json(story_str)

        if req.generate_images:
            for para in model.contents:
                image_prompt = para.image_prompt
                if image_prompt:
                    image_path = self.generate_image(image_prompt)
                    para.image_path = image_path
        
        return model
    
    # Generates images using llm_client and returns its locally stored path
    def generate_image(self, prompt: str) -> str | None:
        res = self.llm_client.generate_image(prompt=prompt)

        return res

