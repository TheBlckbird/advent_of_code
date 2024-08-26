// let mut current_object_result = 0;
// let mut ignore_object_level = -1;

// if object_level_inside < current_object_result_level {
//     if !dont_count {
//         result += current_object_result;
//     }
//     current_object_result = 0;

//     dont_count = false;
// }

// if char.is_ascii_digit() || char == '-' {
//     current_num.push(char);
// } else if char == '{' {
//     object_level_inside += 1;
// } else if char == '}' {
//     object_level_inside -= 1;
// } else if !current_num.is_empty() {
//     current_object_result += current_num.parse::<i32>().unwrap();
//     current_num = String::new();
// }

// if object_level_inside != 0
//     && char == 'r'
//     && input.chars().nth(index + 1).unwrap() == 'e'
//     && input.chars().nth(index + 2).unwrap() == 'd'
// {
//     if current_object_result_level != 0 {
//         current_object_result_level = object_level_inside;
//     }

//     dont_count = true;
// }

// println!("{object_level_inside}");
// println!("{dont_count}");

// print!("{index}, {char}: ");

// if char.is_ascii_digit() || char == '-' {
//     current_num.push(char);
// } else if !current_num.is_empty() {
//     println!("{current_num}");
//     current_object_result += current_num.parse::<i32>().unwrap();
//     current_num.clear();
// }

// match char {
//     '{' => {
//         object_level_inside += 1;

//         if object_level_inside < ignore_object_level {
//             println!("ignored: {}", object_level_inside + 1);
//             current_object_result = 0;
//         } else {
//             result += current_object_result;
//             ignore_object_level = -1;
//         }
//     }
//     '}' => {
//         object_level_inside -= 1;

//         if object_level_inside < ignore_object_level {
//             println!("ignored: {}", object_level_inside + 1);
//             current_object_result = 0;
//             ignore_object_level = -1;
//         } else {
//             result += current_object_result;
//             ignore_object_level = -1;
//         }
//     }
//     _ => {}
// }

// //  if object_level_inside < ignore_object_level

// if object_level_inside != 0
//     && char == 'r'
//     && input.chars().nth(index + 1).unwrap() == 'e'
//     && input.chars().nth(index + 2).unwrap() == 'd'
//     && ignore_object_level == -1
// {
//     ignore_object_level = object_level_inside;
//     println!("ign: {ignore_object_level}");
// }

// println!();

// if char == '{' {
//     object_level_inside += 1;
// } else if char == '}' {
//     object_level_inside -= 1;
// } else if char == 'r'
//     && input.chars().nth(index + 1).unwrap() == 'e'
//     && input.chars().nth(index + 2).unwrap() == 'd'
// {
// }
