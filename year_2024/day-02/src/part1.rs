pub fn process(input: &str) -> String {
    let mut result = 0;
    let reports = parse(input);

    'reports: for report in reports {
        let mut descending = None;
        let mut last_level = 0;

        for level in report {
            let currently_descending = level < last_level;

            match descending {
                Some(descending) => {
                    if descending != currently_descending
                        || (level - last_level).abs() > 3
                        || (level - last_level).abs() < 1
                    {
                        continue 'reports;
                    }
                }
                None => {
                    if last_level != 0 {
                        descending = Some(currently_descending);

                        if (level - last_level).abs() > 3 || (level - last_level).abs() < 1 {
                            continue 'reports;
                        }
                    }
                }
            }

            last_level = level;
        }

        result += 1;
    }

    result.to_string()
}

fn parse(input: &str) -> Vec<Vec<i16>> {
    let mut result = Vec::new();

    for line in input.lines() {
        let mut line_vec = Vec::new();

        for num in line.split(' ') {
            line_vec.push(num.parse().unwrap());
        }

        result.push(line_vec);
    }

    result
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 2.to_string();
        assert_eq!(result, expected);
    }
}
