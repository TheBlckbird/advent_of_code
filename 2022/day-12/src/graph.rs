#[derive(Debug, Clone)]
pub struct Graph {
    adjacency_matrix: Vec<Vec<bool>>,
    size: usize,
}

impl Graph {
    pub fn new(size: usize) -> Self {
        Self {
            adjacency_matrix: vec![vec![false; size]; size],
            size,
        }
    }

    pub fn add_connections(&mut self, node: usize, connections: Vec<usize>) -> Result<(), ()> {
        if node > self.size {
            return Err(());
        }

        for connection in connections {
            if connection > self.size {
                return Err(());
            }

            self.adjacency_matrix[node][connection] = true;
            self.adjacency_matrix[connection][node] = true;
        }

        Ok(())
    }

    pub fn get_neighbors(&self, node: usize) -> Vec<usize> {
        self.adjacency_matrix[node]
            .iter()
            .enumerate()
            .filter_map(|(i, is_connected)| {
                if is_connected == &self.adjacency_matrix[node][0] {
                    // Some(self.nodes[i])
                    Some(i)
                } else {
                    None
                }
            })
            .collect()
    }

    pub fn has_connection(&self, node_a: usize, node_b: usize) -> bool {
        self.adjacency_matrix[node_a][node_b]
    }
}
