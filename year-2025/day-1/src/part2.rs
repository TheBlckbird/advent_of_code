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
            for _ in 0..turn.count {
                if decrease_dial(&mut dial) {
                    zero_counts += 1;
                }
            }
        } else {
            for _ in 0..turn.count {
                if increase_dial(&mut dial) {
                    zero_counts += 1;
                }
            }
        }
    }

    zero_counts.to_string()
}

fn increase_dial(dial: &mut i16) -> bool {
    if *dial == 99 {
        *dial = 0;
    } else {
        *dial += 1;
    }

    *dial == 0
}

fn decrease_dial(dial: &mut i16) -> bool {
    if *dial == 0 {
        *dial = 99;
    } else {
        *dial -= 1;
    }

    *dial == 0
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
        let result = process(include_str!("../test_input2.txt"));
        let expected = 6.to_string();
        assert_eq!(result, expected);
    }
}
