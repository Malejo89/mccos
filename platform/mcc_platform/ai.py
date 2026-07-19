"""
MCC Platform - AI API
"""
import urllib.request
import json

class AiAPI:
    @staticmethod
    def list_local_models():
        # Stub: queries local ollama instance
        try:
            req = urllib.request.Request("http://127.0.0.1:11434/api/tags")
            with urllib.request.urlopen(req, timeout=2) as response:
                data = json.loads(response.read().decode())
                return data.get("models", [])
        except Exception:
            return []

    @staticmethod
    def download_model(model_name: str):
        # Stub: triggers ollama pull
        return True
