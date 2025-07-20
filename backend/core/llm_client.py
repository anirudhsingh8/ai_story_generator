class LLMClient():
    def get_generated_completions(prompt: str) -> str | None:
        print("Got request for {prompt}")