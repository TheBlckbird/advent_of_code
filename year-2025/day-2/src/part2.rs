use itertools::Itertools;
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

    'outer: for i in 2..=stringified_number.len() {
        if !stringified_number.len().is_multiple_of(i) {
            continue;
        }

        let chunks = stringified_number.chars().chunks(stringified_number.len() / i);

        // Check that chunks are all of equal size
        let mut previous_chunk = None;

        let mut iteration = 0;

        for chunk in &chunks {
            iteration += 1;

            let chunk: String = chunk.collect();

            // match chunk_length {
            //     Some(chunk_length) => {
            //         if chunk.len() != chunk_length {
            //             continue 'outer;
            //         }
            //     }
            //     None => chunk_length = Some(chunk.len()),
            // }

            let is_last = iteration == i;

            if let Some(previous_chunk) = previous_chunk {
                if previous_chunk != chunk {
                    continue 'outer;
                } else if is_last {
                    return true;
                }
            }

            previous_chunk = Some(chunk);
        }
    }

    false
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
        let result = process(include_str!("../test_input2.txt"));
        let expected = 4174379265u64.to_string();
        assert_eq!(result, expected);
    }
}
