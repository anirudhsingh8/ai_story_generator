from ..core.deep_infra_llm_client import DeepInfraLLMClient
from ..schemas.story_request import StoryRequest
from ..schemas.story_response import StoryResponse
from ..utils.get_story_prompt import get_story_prompt

class ContentGenerationService():
    text_generation_client: DeepInfraLLMClient

    def __init__(self):
        self.text_generation_client = DeepInfraLLMClient()
    
    text_gen_system_prompt: str = '''
        You are a creative story writer and an image prompt writer, that generates fictional stories alongwith intricate level details of each paragraph in structured JSON format.

        Always follow this output format strictly:
        {
          "summary": "A short 100-word summary of the story",
          "contents": [
            { "text": "Paragraph 1", "image_prompt": "A very detailed decriptions of what this scene would look like if represented in form of an image prompt" },
            { "text": "Paragraph 2", "image_prompt": "A very detailed decriptions of what this scene would look like if represented in form of an image prompt" },
            ...depends upon the number of paragraph user wants
          ]
        }

        Write stories based on the given input: genre, character names/number of characters (either may be present), and number of paragraphs.

        Make the story vivid, imaginative, emotionally engaging, and coherent. The story must reflect the genre clearly and develop the characters throughout the paragraphs. If character names are not provided, make appropriate ones.

        Do not explain anything, just return the final JSON object.
    '''


    def generate_story(self, req: StoryRequest) -> StoryResponse | None:
        prompts = []

        # Add system prompt
        prompts.append({
            "role": "system",
            "content": self.text_gen_system_prompt,
        })

        # Add user prompt
        prompts.append({
            "role": "user",
            "content": get_story_prompt(req),
        })

        story_str = self.text_generation_client.generate_text(messages=prompts)
        return StoryResponse.model_validate_json(story_str)
