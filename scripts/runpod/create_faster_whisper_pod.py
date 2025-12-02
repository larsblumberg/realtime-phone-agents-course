import runpod
from realtime_phone_agents.config import settings

runpod.api_key = settings.runpod.api_key

pod = runpod.create_pod(
    name="Faster Whisper Server",
    image_name="theneuralmaze/faster-whisper-server:latest",
    gpu_type_id=settings.runpod.faster_whisper_gpu_type,
    cloud_type="SECURE",
    gpu_count=1,
    volume_in_gb=20,
    volume_mount_path="/workspace",
    ports="8000/http",
)

print(f"Pod created: {pod.get('id')}")
