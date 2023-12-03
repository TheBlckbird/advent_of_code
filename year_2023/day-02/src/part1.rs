pub fn main(input: &str) -> i64 {
    0
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = main(include_str!("./test_input1.txt"));
        let expected = 4361;
        assert_eq!(result, expected);
    }
}
