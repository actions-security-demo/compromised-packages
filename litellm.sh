#!/bin/bash
set -x

CGROUP_PATH="/sys/fs/cgroup/litellm_limit"
sudo mkdir -p "$CGROUP_PATH"
echo $((1024 * 1024 * 1024)) | sudo tee "$CGROUP_PATH/memory.max"
echo $$ | sudo tee "$CGROUP_PATH/cgroup.procs"

strace -f -e trace=execve,execveat python3 -v -c "print('hello')" 2>&1

# python3 -c "import litellm; print('LiteLLM imported successfully!'); print('Version:', litellm.__version__)"