import uuid

def get_unique_filename() -> str:
    return str(uuid.uuid4())