use regex::Regex;

pub fn process(input: &str) -> String {
    let mut result: i32 = 0;
    let mut is_do = true;

    let re = Regex::new(r"don't\(\)|do\(\)|mul\((\d\d?\d?),(\d\d?\d?)\)").unwrap();
    let captures = re.captures_iter(input);

    for capture in captures {
        let capture_type = capture.get(0).unwrap().as_str();

        if capture_type == "don't()" {
            is_do = false;
        } else if capture_type == "do()" {
            is_do = true;
        } else if is_do {
            result += capture.get(1).unwrap().as_str().parse::<i32>().unwrap()
                * capture.get(2).unwrap().as_str().parse::<i32>().unwrap();
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
        let expected = 48.to_string();
        assert_eq!(result, expected);
    }
}
