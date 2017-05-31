import os
import os.path
import glob


def init_service():
    if os.path.exists('/etc/inwin/post-boot-scripts'):
        return
    os.system("mkdir -p /etc/inwin/post-boot-scripts")


def list_scripts():
    script_list = glob.glob("/etc/inwin/post-boot-scripts/[0-9][0-9]-*")
    return sorted(script_list)


def run_script(path):
    os.system(path)


def main():
    init_service()
    for i in list_scripts():
        run_script(i)


if __name__ == '__main__':
    main()

