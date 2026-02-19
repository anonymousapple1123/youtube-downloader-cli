import os
import stat
import subprocess
import sys


def make_executable(filepath):
    """Make a file executable."""
    if not os.path.exists(filepath):
        print(f"Error: {filepath} not found.")
        sys.exit(1)

    st = os.stat(filepath)
    os.chmod(filepath, st.st_mode | stat.S_IEXEC)


def run_script(command, use_shell=False):
    """Run a script or command safely."""
    try:
        subprocess.run(command, check=True, shell=use_shell)
    except subprocess.CalledProcessError as e:
        print(f"Error while running {command}: {e}")
        sys.exit(1)


def main():
    root_dir = os.path.dirname(os.path.abspath(__file__))

    shell_script = os.path.join(root_dir, "fix_dependencies.sh")
    main_script = os.path.join(root_dir, "main.py")

    # Make shell script executable
    print("Making fir_dependencie.sh executable...")
    make_executable(shell_script)

    # Run shell script
    print("Running fir_dependencie.sh...")
    run_script([shell_script])

    # Run main.py using current Python interpreter
    print("Running main.py...")
    run_script([sys.executable, main_script])

    print("Done.")


if __name__ == "__main__":
    main()
