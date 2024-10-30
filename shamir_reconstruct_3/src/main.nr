struct ShareArray {
    x: Field,
    y: [Field; 32]
}

pub fn main(shares: [ShareArray; 3]) -> pub [Field; 32] {
    let mut secret: [Field; 32] = [0; 32];

    // Reconstruct each secret value independently
    for i in 0..32 {
        // Lagrange interpolation for each secret value
        let mut term0 = shares[0].y[i];
        term0 = term0 * (-shares[1].x) * (-shares[2].x);
        term0 = term0 / ((shares[0].x - shares[1].x) * (shares[0].x - shares[2].x));

        let mut term1 = shares[1].y[i];
        term1 = term1 * (-shares[0].x) * (-shares[2].x);
        term1 = term1 / ((shares[1].x - shares[0].x) * (shares[1].x - shares[2].x));

        let mut term2 = shares[2].y[i];
        term2 = term2 * (-shares[0].x) * (-shares[1].x);
        term2 = term2 / ((shares[2].x - shares[0].x) * (shares[2].x - shares[1].x));

        secret[i] = term0 + term1 + term2;
    }

    secret
}
