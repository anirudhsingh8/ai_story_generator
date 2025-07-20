from ..core.config import get_config
from ..utils.clean_llm_output import clean_llm_output
from openai import OpenAI

class DeepInfraLLMClient():
    def generate_text(self, messages: list) -> object | None:
        config = get_config()
        openai_client = OpenAI(
            base_url=config.deepinfra_base_url,
            api_key=config.deepinfra_api_key
        )
        
        res = openai_client.chat.completions.create(
            model=config.model,
            messages=messages
        )
        
        generated_text = clean_llm_output(res.choices[0].message.content)
        return generated_text
        