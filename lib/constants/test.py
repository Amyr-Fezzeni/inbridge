def sort_strings(mylist):
    """
    Sorts a list of strings in alphabetical order.

    Args:
        mylist (list): List of strings to be sorted.

    Returns:
        list: A new list containing the sorted strings.
    """
    return sorted(mylist)

# Example usage:
my_strings = ["banana", "apple", "grape", "cherry"]
sorted_strings = sort_strings(my_strings)
print("Sorted strings:", sorted_strings)
