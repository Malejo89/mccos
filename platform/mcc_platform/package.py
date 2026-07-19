"""
MCC Platform - Package API
"""

class PackageAPI:
    @staticmethod
    def install_package(package_name: str):
        # Stub: calls apt-get install or flatpak install
        return True

    @staticmethod
    def is_installed(package_name: str):
        # Stub: calls dpkg -s
        return False
