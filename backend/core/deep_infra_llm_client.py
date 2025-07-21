from ..core.config import get_config
from ..utils.clean_llm_output import clean_llm_output
from ..utils.get_unique_filename import get_unique_filename
from openai import OpenAI
import base64

class DeepInfraLLMClient():
    def generate_text(self, messages: list) -> object | None:
        config = get_config()
        openai_client = OpenAI(
            base_url=config.deepinfra_base_url,
            api_key=config.deepinfra_api_key
        )
        
        res = openai_client.chat.completions.create(
            model=config.text_model,
            messages=messages
        )
        
        generated_text = clean_llm_output(res.choices[0].message.content)
        return generated_text
        
    def generate_image(self, prompt: str) -> str | None:
        config = get_config()

        client = OpenAI(
            base_url=config.deepinfra_base_url,
            api_key=config.deepinfra_api_key,
        )

        response = client.images.generate(
            prompt=prompt,
            model=config.image_model,
            n=1,
            size="1024x1024",
        )

        base64_data = response.data[0].b64_json
        image_data = base64.b64decode(base64_data)
        file_name = f"{get_unique_filename()}.png"
        output_path = f"backend/static/{file_name}"

        with open(output_path, "wb") as file:
            file.write(image_data)

        return file_name

