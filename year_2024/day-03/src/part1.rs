pub fn process(input: &str) -> String {
    todo!()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = todo!().to_string();
        assert_eq!(result, expected);
    }
}
