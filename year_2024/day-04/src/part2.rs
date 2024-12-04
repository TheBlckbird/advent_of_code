use regex::Regex;

pub fn process(input: &str) -> String {
    let re = Regex::new(
        r"(?=M.S[XMAS\n]{139}A[XMAS\n]{139}M.S|S.M[XMAS\n]{139}A[XMAS\n]{139}S.M|M.M[XMAS\n]{139}A[XMAS\n]{139}S.S|S.S[XMAS\n]{139}A[XMAS\n]{139}M.M)", // theoretically works, / ran it with regex101.com
    )
    .unwrap();
    let matches = re.find_iter(input).count();

    matches.to_string()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input2.txt"));
        let expected = 9.to_string();
        assert_eq!(result, expected);
    }
}
