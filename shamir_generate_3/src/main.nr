// Define the data structures
struct ShareArray {
    x: u64,
    y: [u64; 32],
}

fn main(
    secret: [u64; 32], // Array of 32 secret integers
    a1: [u64; 32], // Array of first coefficients for each secret
    a2: [u64; 32] // Array of second coefficients for each secret
) -> pub [ShareArray; 5] {
    // Verify each secret value is in valid range
    for i in 0..32 {
        assert(secret[i] < 7919);
    }

    // Create array to store all shares
    let mut shares: [ShareArray; 5] = [
        ShareArray { x: 0, y: [0; 32] },
        ShareArray { x: 0, y: [0; 32] },
        ShareArray { x: 0, y: [0; 32] },
        ShareArray { x: 0, y: [0; 32] },
        ShareArray { x: 0, y: [0; 32] }
    ];

    // Generate shares for each x value
    shares[0] = create_share_array(1, secret, a1, a2);
    shares[1] = create_share_array(2, secret, a1, a2);
    shares[2] = create_share_array(3, secret, a1, a2);
    shares[3] = create_share_array(4, secret, a1, a2);
    shares[4] = create_share_array(5, secret, a1, a2);

    shares
}

fn create_share_array(x: u64, secret: [u64; 32], a1: [u64; 32], a2: [u64; 32]) -> ShareArray {
    let x_field = x;
    let x_squared = x_field * x_field;

    let mut y_values: [u64; 32] = [0; 32];

    // Create share for each secret value
    for i in 0..32 {
        // Evaluate polynomial f(x) = secret + a1*x + a2*x^2 for each secret
        y_values[i] = secret[i] + 
                      (a1[i] * x_field) + // 2 threshold
                      (a2[i] * x_squared); // 3 threshold
    }

    ShareArray { x: x_field, y: y_values }
}
