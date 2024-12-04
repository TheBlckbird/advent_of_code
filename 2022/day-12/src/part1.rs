use crate::graph::Graph;

pub fn process(input: &str) -> String {
    parse_graph(input);
    todo!()
}

fn parse_graph(input: &str) -> Graph {
    let mut graph = Graph::new(input.lines().count());

    let map: Vec<Vec<char>> = input
        .lines()
        .map(|i| i.chars().collect::<Vec<char>>())
        .collect();

    for (y, line) in map.iter().enumerate() {
        for (x, char) in line.iter().enumerate() {
            let mut left = true;
            let mut right = true;
            let mut up = true;
            let mut down = true;

            if x == 0 {
                left = false;
            }
            if y == 0 {
                up = false;
            }
            if x == line.len() - 1 {
                right = false;
            }
            if y == line.len() - 1 {
                down = false;
            }

            if left &&  {
                graph
                    .add_connections(y * line.len() + x, vec![])
                    .unwrap();
            }
        }
    }

    todo!()
}

fn are_chars_near(a: char, b:char) -> bool {
    todo!()
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 31.to_string();
        assert_eq!(result, expected);
    }
}
