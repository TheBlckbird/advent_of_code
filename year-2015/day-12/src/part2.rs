pub fn process(input: &str) -> String {
    println!("neweee");
    let mut input = String::from(input);
    let mut result = 0;
    let mut current_num = String::new();

    // let mut object_level_inside = 0;

    'w: while let Some(red_occurrence) = input.find("red") {
        let mut current_object_level = 0;
        let mut current_array_level = 0;

        let mut removed_buf = String::new();

        // println!("w: {input}");
        'l: loop {
            // println!("1");
            // println!("{current_object_level}");
            let removed = input.remove(red_occurrence);
            removed_buf.push(removed);

            if removed == '{' {
                current_object_level += 1;
            } else if removed == '}' {
                if current_object_level == 0 {
                    // input.insert(red_occurrence, '}');
                    // println!("b: {input}");
                    // println!();
                    break 'l;
                }

                current_object_level -= 1;
            } else if removed == '[' {
                current_array_level += 1;
            } else if removed == ']' {
                if current_array_level == 0 {
                    input.insert_str(red_occurrence, &removed_buf);
                    // input.remove(red_occurrence);
                    // input.remove(red_occurrence + 1);
                    // input.remove(red_occurrence + 2);
                    break 'w;
                } else {
                    current_array_level -= 1;
                }
            }

            // println!("l: {input}");
        }
        current_object_level = 0;
        // current_array_level = 0;
        removed_buf.clear();

        let index = input.len() - red_occurrence;
        input = input.chars().rev().collect::<String>();
        // println!("r: {input}");
        'l: loop {
            let removed = input.remove(index);

            if removed == '}' {
                current_object_level += 1;
            } else if removed == '{' {
                if current_object_level == 0 {
                    // input.insert(index, '{');
                    // println!("Ok, break");
                    break 'l;
                } else {
                    current_object_level -= 1;
                }
                // } else if removed == ']' {
                //     current_array_level += 1;
                // } else if removed == '[' {
                //     if current_array_level == 0 {
                //         input.insert_str(red_occurrence, &removed_buf);
                //         // input.remove(index);
                //         // input.remove(index + 1);
                //         // input.remove(index + 2);
                //         break 'w;
                //     } else {
                //         current_array_level -= 1;
                //     }
            }
            // println!("l: {input}");
        }
        input = input.chars().rev().collect::<String>();
        // println!("e: {input}");
    }

    for char in input.chars() {
        if char.is_ascii_digit() || char == '-' {
            current_num.push(char);
        } else if !current_num.is_empty() {
            result += current_num.parse::<i32>().unwrap();
            current_num = String::new();
        }
    }

    result.to_string()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input2.txt"));
        let expected = "6";
        assert_eq!(result, expected);
    }
}
