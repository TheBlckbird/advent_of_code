pub fn main(input: &str) -> String {
    "".to_owned()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn it_works() {
        let result = main(include_str!("./test_input2.txt"));
        let expected = "";
        assert_eq!(result, expected);
    }
}
