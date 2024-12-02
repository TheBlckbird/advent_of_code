pub fn process(input: &str) -> String {
    let mut result = 0;
    let reports = parse(input);

    'reports: for report in reports {
        if check_safety(&report) {
            result += 1;
        } else {
            for i in 0..5 {
                let mut changed_report = report.clone();
                changed_report.remove(i);

                if check_safety(&changed_report) {
                    result += 1;
                    continue;
                }
            }
        }
    }

    result.to_string()
}

fn check_safety(report: &Vec<i16>) -> bool {
    let mut descending = None;
    let mut last_level = 0;
    let mut is_safe = true;

    for level in report {
        let currently_descending = level < &last_level;

        match descending {
            Some(descending) => {
                if descending != currently_descending
                    || (level - last_level).abs() > 3
                    || (level - last_level).abs() < 1
                {
                    is_safe = false;
                }
            }
            None => {
                if last_level != 0 {
                    descending = Some(currently_descending);

                    if (level - last_level).abs() > 3 || (level - last_level).abs() < 1 {
                        is_safe = false;
                    }
                }
            }
        }

        last_level = *level;
    }

    is_safe
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
        let result = process(include_str!("../test_input2.txt"));
        let expected = 4.to_string();
        assert_eq!(result, expected);
    }
}
