pub fn process(input: &str) -> String {
    let mut result = 0;
    let mut current_num = String::new();

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
        let result = process(include_str!("../test_input1.txt"));
        let expected = "0";
        assert_eq!(result, expected);
    }
}
