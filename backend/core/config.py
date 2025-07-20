import os
from functools import lru_cache

class Config:
    deepinfra_base_url: str
    deepinfra_api_key: str
    model: str
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

    def __init__(self):
        self.deepinfra_base_url = os.getenv("DEEPINFRA_BASE_URL")
        self.deepinfra_api_key = os.getenv("DEEPINFRA_API_KEY")
        self.model = os.getenv("MODEL")

@lru_cache
def get_config():
    return Config()