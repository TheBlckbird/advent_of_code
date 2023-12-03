pub fn main(input: &str) -> i64 {
    0
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = main(include_str!("./test_input2.txt"));
        let expected = 0;
        assert_eq!(result, expected);
    }
}
