use cairo_verifier::{
    air::traces::TracesConfig, table_commitment::table_commitment::TableCommitmentConfig,
    vector_commitment::vector_commitment::VectorCommitmentConfig,
};

fn get() -> TracesConfig {
    return TracesConfig {
        original: TableCommitmentConfig {
            n_columns: 0x7,
            vector: VectorCommitmentConfig {
                height: 0x16, n_verifier_friendly_commitment_layers: 0x16
            },
        },
        interaction: TableCommitmentConfig {
            n_columns: 0x3,
            vector: VectorCommitmentConfig {
                height: 0x16, n_verifier_friendly_commitment_layers: 0x16
            },
        },
    };
}
