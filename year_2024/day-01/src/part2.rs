pub fn process(input: &str) -> String {
    let mut result = 0;
    let parsed = parse(input);

    for num in parsed.0 {
        let occurrences = parsed
            .1
            .iter()
            .filter(|&i| i == &num)
            .collect::<Vec<&i32>>()
            .len();

        result += occurrences as i32 * num;
    }

    result.to_string()
}

fn parse(input: &str) -> (Vec<i32>, Vec<i32>) {
    let mut result = (Vec::new(), Vec::new());

    for line in input.lines() {
        let mut parts = line.split("   ");
        result.0.push(parts.next().unwrap().parse().unwrap());
        result.1.push(parts.next().unwrap().parse().unwrap());
    }

    result
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input2.txt"));
        let expected = 31.to_string();
        assert_eq!(result, expected);
    }
}
