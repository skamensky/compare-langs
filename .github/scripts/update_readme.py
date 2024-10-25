import re
import sys
from pathlib import Path

root = Path(__file__).parent.parent.parent
readme = root / 'README.md'
build_output = root / 'build_output.txt'
test_output = root / 'test_output.txt'


def read_file(file_path):
    """Reads the content of a file and returns it as a string."""
    try:
        with open(file_path) as f:
            return f.read()
    except FileNotFoundError:
        print(f"Error: {file_path} not found.")
        sys.exit(1)

def update_readme(build_output, test_output):
    """Updates the README.md file with new build and test outputs."""
    try:
        with open('README.md') as f:
            readme = f.read()
    except FileNotFoundError:
        print("Error: README.md not found.")
        sys.exit(1)

    # Define the patterns to search for
    build_pattern = r'(<!-- BUILD_SCRIPT_OUTPUT_START -->)(.*?)(<!-- BUILD_SCRIPT_OUTPUT_END -->)'
    test_pattern = r'(<!-- TEST_SCRIPT_OUTPUT_START -->)(.*?)(<!-- TEST_SCRIPT_OUTPUT_END -->)'

    
    # Replace the content between the markers with the new outputs
    # add ``` to the start and end of the output to format it as code bloc
    new_readme = re.sub(build_pattern, r'\1\n```\n{}\n```\n\3'.format(build_output), readme, flags=re.DOTALL)
    new_readme = re.sub(test_pattern, r'\1\n```\n{}\n```\n\3'.format(test_output), new_readme, flags=re.DOTALL)

    # Write the updated README.md
    with open('README.md', 'w') as f:
        f.write(new_readme)

def main():

    update_readme(read_file(build_output), read_file(test_output))

if __name__ == "__main__":
    main()
