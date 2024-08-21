fn main() {
    let result = calc("3113322113");

    println!("Part 1: {}", result.0);
    println!("Part 2: {}", result.1);
}

fn calc(input: &str) -> (usize, usize) {}

fn test_requirements(input: String) -> bool {
    true
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn part_one() {
        let res = test_requirements();
    }
}
