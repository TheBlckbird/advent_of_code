use regex::Regex;

pub fn process(input: &str) -> String {
    let mut result: i32 = 0;
    let re = Regex::new(r"mul\((\d\d?\d?),(\d\d?\d?)\)").unwrap();

    let captures = re.captures_iter(input);

    for capture in captures {
        result += capture.get(1).unwrap().as_str().parse::<i32>().unwrap()
            * capture.get(2).unwrap().as_str().parse::<i32>().unwrap();
    }

    result.to_string()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 161.to_string();
        assert_eq!(result, expected);
    }
}
