from input imort INPUT

input_array = INPUT.split("\n\n")
input_array_splitted = []

for elv_calories in input_array:
    input_array_splitted.append(elv_calories.split("\n"))
        

input_array_splitted =  [list( map(int,i) ) for i in input_array_splitted]

    

biggest_calorie_pack = 0

for calories in input_array_splitted:
    calorie_pack = 0
    for calorie in calories:
        calorie_pack += calorie
        
    if calorie_pack > biggest_calorie_pack:
        biggest_calorie_pack = calorie_pack
        
print(biggest_calorie_pack)