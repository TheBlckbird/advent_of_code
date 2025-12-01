#[derive(Debug, PartialEq)]
enum Direction {
    Left,
    Right,
}

#[derive(Debug)]
struct Turn {
    pub direction: Direction,
    pub count: u16,
}

impl Turn {
    fn new(direction: Direction, count: u16) -> Self {
        Self { direction, count }
    }
}

pub fn process(input: &str) -> String {
    let turns = parse(input);

    let mut dial = 50;
    let mut zero_counts = 0;

    for turn in &turns {
        if turn.direction == Direction::Left {
            dial -= turn.count as i16;

            while dial.is_negative() {
                dial += 100;
            }
        } else {
            dial += turn.count as i16;

            while dial > 99 {
                dial -= 100;
            }
        }

        if dial == 0 {
            zero_counts += 1;
        }
    }

    println!("{dial}");

    zero_counts.to_string()
}

fn parse(input: &str) -> Vec<Turn> {
    let mut turns = Vec::new();

    for line in input.lines() {
        let mut characters = line.chars();

        let direction = match characters.next().unwrap() {
            'L' => Direction::Left,
            'R' => Direction::Right,
            _ => continue,
        };

        let turn_count = characters.collect::<String>().parse().unwrap();
        turns.push(Turn::new(direction, turn_count));
    }

    turns
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 3.to_string();
        assert_eq!(result, expected);
    }
}
