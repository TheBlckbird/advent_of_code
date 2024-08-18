use std::fs::read_to_string;

enum InputType {
    Real,
    Example,
}

fn main() {
    let _ = calc(InputType::Real);
}

fn calc(input_type: InputType) -> (usize, usize) {
    let mut all_chars = 0;
    let mut real_chars = 0;
    let mut encoded_chars = 0;

    for line in parse_input(input_type) {
        if line.is_empty() {
            continue;
        }

        all_chars += line.len();
        encoded_chars += line.len() + 2;

        for char in line.chars() {
            match char {
                '\\' => {
                    encoded_chars += 1;
                    println!("\\");
                }
                '"' => {
                    encoded_chars += 1;
                    println!("\"");
                }
                _ => {}
            }
        }

        println!("{line}");
        println!("{encoded_chars}");
        println!();

        let mut remaining = line;
        let mut current_iteration = 0;

        while !remaining.is_empty() {
            current_iteration += 1;

            if current_iteration == 1 || remaining.len() == 1 {
                remaining.remove(0);
                continue;
            }

            match remaining.chars().next().unwrap() {
                '\\' => {
                    remaining.remove(0);

                    match remaining.chars().next().unwrap() {
                        'x' => {
                            remaining.remove(0);
                            remaining.remove(0);
                            remaining.remove(0);
                        }
                        '"' => {
                            remaining.remove(0);
                        }
                        '\\' => {
                            remaining.remove(0);
                        }
                        _ => {
                            remaining.remove(0);
                        }
                    }

                    real_chars += 1;
                }
                '"' => {
                    break;
                }
                _ => {
                    remaining.remove(0);
                    real_chars += 1;
                }
            }
        }
    }

    let part_one = all_chars - real_chars;
    let part_two = encoded_chars - all_chars;

    println!("Part 1: {part_one}");
    println!("Part 2: {part_two}");

    (part_one, part_two)
}

fn parse_input(input_type: InputType) -> Vec<String> {
    let contents = read_to_string(match input_type {
        InputType::Real => "./input.txt",
        InputType::Example => "./input-example.txt",
    })
    .unwrap();
    contents.split('\n').map(|line| line.to_string()).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = calc(InputType::Example);
        assert_eq!(result.0, 12);
    }

    #[test]
    fn test_part_two() {
        let result = calc(InputType::Example);
        assert_eq!(result.1, 19);
    }
}
