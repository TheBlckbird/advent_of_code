pub fn main(input: &str) -> i64 {
    let mut output = 0;

    let lines: Vec<&str> = input.lines().collect();

    // Convert each line into a 2D array of characters
    let mut char_2d_array: Vec<Vec<char>> = Vec::new();
    for line in lines {
        let char_array: Vec<char> = line.chars().collect();
        char_2d_array.push(char_array);
    }

    let mut current_number = String::new();

    for (line_index, line) in char_2d_array.iter().enumerate() {
        for (char_index, char) in line.iter().enumerate() {
            if !char.is_numeric() {
                continue;
            }

            current_number.push(*char);

            if (line_index != char_2d_array.len()
                && char_index != char_2d_array[line_index].len() - 1)
                && (char_2d_array[line_index][char_index + 1].is_numeric())
            {
                continue;
            }

            let mut characters_around = String::with_capacity((current_number.len() + 2) * 2 + 2);

            for _ in 0..current_number.chars().count() {
                if line_index != 0 {
                    characters_around.push(char_2d_array[line_index - 1][char_index]);
                }

                if line_index != char_2d_array.len() - 1 {
                    characters_around.push(char_2d_array[line_index + 1][char_index]);
                }
            }

            if char_index + 1 - current_number.len() > 0 {
                // left
                characters_around
                    .push(char_2d_array[line_index][char_index - current_number.len()]);
            }

            if char_index + 1 < char_2d_array[line_index].len() {
                // right
                characters_around.push(char_2d_array[line_index][char_index + 1]);
            }

            if line_index > 0 && char_index + 1 - current_number.len() > 0 {
                // top left
                characters_around
                    .push(char_2d_array[line_index - 1][char_index - current_number.len()]);
            }

            if line_index > 0 && char_index + 1 < char_2d_array[line_index].len() {
                // top right
                characters_around.push(char_2d_array[line_index - 1][char_index + 1]);
            }

            if line_index != char_2d_array.len() - 1 && char_index + 1 - current_number.len() > 0 {
                // bottom left
                characters_around
                    .push(char_2d_array[line_index + 1][char_index - current_number.len()]);
            }

            if line_index != char_2d_array.len() - 1
                && char_index + 1 < char_2d_array[line_index].len()
            {
                // bottom right
                characters_around.push(char_2d_array[line_index + 1][char_index + 1]);
            }

            for character_around in characters_around.chars() {
                if character_around != '.' {
                    output += current_number.parse::<i64>().unwrap();
                    break;
                }
            }

            current_number = "".to_owned();
        }
    }

    output
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = main(include_str!("./test_input1.txt"));
        let expected = 4361;
        assert_eq!(result, expected);
    }
}
