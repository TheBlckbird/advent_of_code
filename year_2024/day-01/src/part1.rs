pub fn process(input: &str) -> String {
    let mut result = 0;

    let mut parsed = parse(input);

    while !parsed.0.is_empty() {
        let min_0 = parsed.0.iter().min().unwrap();
        let min_1 = parsed.1.iter().min().unwrap();

        result += (min_0 - min_1).abs();

        parsed
            .0
            .remove(parsed.0.iter().position(|&i| i == *min_0).unwrap());

        parsed
            .1
            .remove(parsed.1.iter().position(|&i| i == *min_1).unwrap());
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
        let result = process(include_str!("../test_input1.txt"));
        let expected = 11.to_string();
        assert_eq!(result, expected);
    }
}
