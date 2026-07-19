"""
MCC Platform - Hardware API
"""
import subprocess

class HardwareAPI:
    @staticmethod
    def get_cpu_info():
        # Stub: calls lscpu
        return {"architecture": "x86_64", "model": "Generic CPU"}

    @staticmethod
    def get_gpu_info():
        # Stub: calls lspci | grep VGA
        return {"vendor": "Generic", "device": "VGA Compatible Controller"}

    @staticmethod
    def is_virtual_machine():
        # Stub: calls systemd-detect-virt
        try:
            result = subprocess.run(["systemd-detect-virt"], capture_output=True, text=True)
            return result.returncode == 0
        except Exception:
            return False
