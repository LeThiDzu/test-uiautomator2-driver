import re

def re_find_all(bounds):
    """
    Find all occurrences of a pattern in a string using regex.

    Args:
        pattern (str): The regex pattern to search for.
        string (str): The string to search within.

    Returns:
        list: A list of all matches found.
    """
    # Compile the regex pattern
    compiled_pattern = re.compile(r'\d+')

    # Find all matches in the string
    matches = compiled_pattern.findall(bounds)

    return matches
