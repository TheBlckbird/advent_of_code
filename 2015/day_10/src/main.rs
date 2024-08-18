fn main() {
    let result = calc("3113322113");

    println!("Part 1: {}", result.0);
    println!("Part 2: {}", result.1);
}

fn calc(input: &str) -> (usize, usize) {
    let mut current = input.to_string();
    let mut new;

    println!("{current}");

    for _ in 0..40 {
        new = String::new();

        let mut last_char = current.chars().next().unwrap();
        let mut last_char_count = 1;

        for char in current.chars().skip(1) {
            if char == last_char {
                last_char_count += 1;
            } else {
                new.push_str(format!("{last_char_count}{last_char}").as_str());

                last_char = char;
                last_char_count = 1;
            }
        }

        new.push_str(format!("{last_char_count}{last_char}").as_str());

        // println!("{new}");

        current.clone_from(&new);
    }

    let part_one = current.len();

    for _ in 0..10 {
        new = String::new();

        let mut last_char = current.chars().next().unwrap();
        let mut last_char_count = 1;

        for char in current.chars().skip(1) {
            if char == last_char {
                last_char_count += 1;
            } else {
                new.push_str(format!("{last_char_count}{last_char}").as_str());

                last_char = char;
                last_char_count = 1;
            }
        }

        new.push_str(format!("{last_char_count}{last_char}").as_str());

        // println!("{new}");

        current.clone_from(&new);
    }

    let part_two = current.len();

    (part_one, part_two)
}
