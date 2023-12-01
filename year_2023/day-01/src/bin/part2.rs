fn main() {
    let input = include_str!("../input.txt");
    let output = start(input);
    dbg!(output);
}

fn start(input: &str) -> i64 {
    let mut output = 0;

    for line in input.lines() {
        let mut remaining_line_forward = line.to_owned();
        let mut remaining_line_backward = line.to_owned();
        let mut first_digit = ' ';
        let mut last_digit = ' ';

        loop {
            if (remaining_line_forward.starts_with("one")
                || remaining_line_forward.starts_with('1'))
                && first_digit == ' '
            {
                first_digit = '1';
            } else if (remaining_line_forward.starts_with("two")
                || remaining_line_forward.starts_with('2'))
                && first_digit == ' '
            {
                first_digit = '2';
            } else if (remaining_line_forward.starts_with("three")
                || remaining_line_forward.starts_with('3'))
                && first_digit == ' '
            {
                first_digit = '3';
            } else if (remaining_line_forward.starts_with("four")
                || remaining_line_forward.starts_with('4'))
                && first_digit == ' '
            {
                first_digit = '4';
            } else if (remaining_line_forward.starts_with("five")
                || remaining_line_forward.starts_with('5'))
                && first_digit == ' '
            {
                first_digit = '5';
            } else if (remaining_line_forward.starts_with("six")
                || remaining_line_forward.starts_with('6'))
                && first_digit == ' '
            {
                first_digit = '6';
            } else if (remaining_line_forward.starts_with("seven")
                || remaining_line_forward.starts_with('7'))
                && first_digit == ' '
            {
                first_digit = '7';
            } else if (remaining_line_forward.starts_with("eight")
                || remaining_line_forward.starts_with('8'))
                && first_digit == ' '
            {
                first_digit = '8';
            } else if (remaining_line_forward.starts_with("nine")
                || remaining_line_forward.starts_with('9'))
                && first_digit == ' '
            {
                first_digit = '9';
            } else if !remaining_line_forward.is_empty() {
                remaining_line_forward = remaining_line_forward[1..].to_owned();
            }

            if (remaining_line_backward.ends_with("one") || remaining_line_backward.ends_with('1'))
                && last_digit == ' '
            {
                last_digit = '1';
            } else if (remaining_line_backward.ends_with("two")
                || remaining_line_backward.ends_with('2'))
                && last_digit == ' '
            {
                last_digit = '2';
            } else if (remaining_line_backward.ends_with("three")
                || remaining_line_backward.ends_with('3'))
                && last_digit == ' '
            {
                last_digit = '3';
            } else if (remaining_line_backward.ends_with("four")
                || remaining_line_backward.ends_with('4'))
                && last_digit == ' '
            {
                last_digit = '4';
            } else if (remaining_line_backward.ends_with("five")
                || remaining_line_backward.ends_with('5'))
                && last_digit == ' '
            {
                last_digit = '5';
            } else if (remaining_line_backward.ends_with("six")
                || remaining_line_backward.ends_with('6'))
                && last_digit == ' '
            {
                last_digit = '6';
            } else if (remaining_line_backward.ends_with("seven")
                || remaining_line_backward.ends_with('7'))
                && last_digit == ' '
            {
                last_digit = '7';
            } else if (remaining_line_backward.ends_with("eight")
                || remaining_line_backward.ends_with('8'))
                && last_digit == ' '
            {
                last_digit = '8';
            } else if (remaining_line_backward.ends_with("nine")
                || remaining_line_backward.ends_with('9'))
                && last_digit == ' '
            {
                last_digit = '9';
            } else if !remaining_line_backward.is_empty() {
                remaining_line_backward =
                    remaining_line_backward[..remaining_line_backward.len() - 1].to_owned();
            }

            if (first_digit != ' ' && last_digit != ' ') || remaining_line_forward.is_empty() {
                break;
            }
        }

        if last_digit == ' ' {
            last_digit = first_digit;
        }
        let number = format!("{}{}", first_digit, last_digit);
        dbg!(line);
        dbg!(&number);
        output += number.parse::<i64>().unwrap();
    }

    output
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = start(include_str!("../test_input2.txt"));
        dbg!(result);
        assert_eq!(result, 281);
    }
}
