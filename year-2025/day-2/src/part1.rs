use std::ops::RangeInclusive;

pub fn process(input: &str) -> String {
    let ranges = parse(input);

    let mut sum = 0;

    for range in ranges {
        for number in range {
            if check_number_repetition(number) {
                sum += number;
            }
        }
    }

    sum.to_string()
}

fn check_number_repetition(number: u64) -> bool {
    let stringified_number = number.to_string();

    if !stringified_number.len().is_multiple_of(2) {
        return false;
    }

    let (part1, part2) = stringified_number.split_at_checked(stringified_number.len() / 2).unwrap();

    part1 == part2
}

fn parse(input: &str) -> Vec<RangeInclusive<u64>> {
    let mut ranges = Vec::new();

    for raw_range in input.split(',') {
        let mut range_parts = raw_range.split('-');
        let range = range_parts.next().unwrap().trim().parse().unwrap()
            ..=range_parts.next().unwrap().trim().parse().unwrap();
        ranges.push(range);
    }

    ranges
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 1227775554.to_string();
        assert_eq!(result, expected);
    }
}
