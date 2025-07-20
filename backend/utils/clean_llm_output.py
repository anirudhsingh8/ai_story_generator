def clean_llm_output(llm_out: str):
    return llm_out.replace("```json", "").replace("```", "")