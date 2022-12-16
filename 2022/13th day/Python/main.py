input = """
[1,1,5,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
"""

def parse_input(input):
    # make a list of all the lines in the input
    lines = input.splitlines()
    # remove the empty lines
    lines = [line for line in lines if line.strip()]
    # split the lines into two lists
    lines1 = lines[::2]
    lines2 = lines[1::2]
    # convert the lines into lists
    lists1 = [eval(line) for line in lines1]
    lists2 = [eval(line) for line in lines2]
    # return the two lists
    return lists1, lists2


input_parsed = parse_input(input)
lists1 = input_parsed[0]
lists2 = input_parsed[1]

def is_list(item):
    return type(item) == list

def check_smaller(list1, list2):
    list1_item = list1
    list2_item = list2

    left_is_smaller = None

    print()
    print(list1_item)
    print(list2_item)

    if is_list(list1_item) and is_list(list2_item):
        
        if len(list1_item) < len(list2_item):
            return False
            

        for item_index, item in enumerate(list1_item):
            return check_smaller(item, list2[item_index])

    elif is_list(list1_item):
        list2_item = [list2]
        return check_smaller(list1_item, list2_item)

    elif is_list(list2_item):
        list1_item = [list1]
        return check_smaller(list1_item, list2_item)

    else:
        if list1_item <= list2_item:
            left_is_smaller = True

        else:
            return False
            

    return left_is_smaller


for lists_index, list1 in enumerate(lists1):
    list2 = lists2[lists_index]
    print(list1)
    print(check_smaller(list1[lists_index], list2[lists_index]))