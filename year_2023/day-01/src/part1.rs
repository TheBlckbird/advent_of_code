pub fn main(input: &str) -> i64 {
    let mut output = 0;

    for line in input.lines() {
        let mut first_digit = ' ';
        let mut last_digit = ' ';

        for character in line.chars() {
            if first_digit == ' ' && character.is_numeric() {
                first_digit = character;
            } else if character.is_numeric() {
                last_digit = character;
            }
        }

        if last_digit == ' ' {
            last_digit = first_digit;
        }
        let number = format!("{}{}", first_digit, last_digit);
        output += number.parse::<i64>().unwrap();
    }

    output
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = main(include_str!("./test_input1.txt"));
        assert_eq!(result, 142);
    }
}
